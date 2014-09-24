class SuperAdmin < ActiveRecord::Base

  has_secure_password

  # Callbacks
  before_create :generate_auth_token

  # Validations
  validates :name,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::NAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::NAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::NAME_FORMAT_REG_EXP}

  validates :username,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
    :length => {:minimum => ConfigCenter::GeneralValidations::USERNAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::USERNAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::USERNAME_FORMAT_REG_EXP}

  validates :email,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
    :format => {:with => ConfigCenter::GeneralValidations::EMAIL_FORMAT_REG_EXP}

  validates :password,
   :presence => true,
   :format => {:with => ConfigCenter::GeneralValidations::PASSWORD_FORMAT_REG_EXP},
   unless: Proc.new { |admin| admin.password.blank? }

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> admin.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("
                                            LOWER(name) LIKE LOWER('%#{query}%') OR\
                                            LOWER(username) LIKE LOWER('%#{query}%') OR\
                                            LOWER(email) LIKE LOWER('%#{query}%') OR")
                        }

  # FIX ME - Specs need to be written
  def self.find_by_email_or_username(query)
    self.where("LOWER(email) = LOWER('#{query}') OR LOWER(username) = LOWER('#{query}')").first
  end

  def generate_auth_token
    self.auth_token = SecureRandom.hex unless self.auth_token
  end

  # Exclude some attributes info from json output.
  def as_json(options={})
    exclusion_list = []
    exclusion_list += ConfigCenter::Defaults::EXCLUDED_JSON_ATTRIBUTES
    exclusion_list += ConfigCenter::SuperAdmin::EXCLUDED_JSON_ATTRIBUTES
    options[:except] ||= exclusion_list
    super(options)
  end

  def self.authenticate(login_handle, password)
    super_admin = SuperAdmin.where("LOWER(email) = LOWER('#{login_handle}') OR LOWER(username) = LOWER('#{login_handle}')").first
    authenticated = false
    # If the user exists with the given username / password
    if super_admin
      # Check if the password matches
      # Invalid Login: Password / Username doesn't match
      if super_admin.authenticate(password) == false
        heading = I18n.translate("authentication.error")
        alert = I18n.translate("authentication.invalid_login")
      end
      # If successfully authenticated.
      heading = I18n.translate("authentication.success")
      alert = I18n.translate("authentication.logged_in_successfully")
      authenticated = true
    # If the user with provided email doesn't exist
    else
      heading = I18n.translate("authentication.error")
      alert = I18n.translate("authentication.user_not_found")
    end
    return authenticated, super_admin, heading, alert
  end

end
