class Admin < ActiveRecord::Base

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

  validates :status, :presence=> true, :inclusion => { :in => ConfigCenter::Admin::STATUS_LIST.keys }

  validates :email,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
    :format => {:with => ConfigCenter::GeneralValidations::EMAIL_FORMAT_REG_EXP}

  validates :password,
   :presence => true,
   :format => {:with => ConfigCenter::GeneralValidations::PASSWORD_FORMAT_REG_EXP},
   unless: Proc.new { |admin| admin.password.blank? }

  validates :trust, presence: true

  # Associations
  belongs_to :trust

  state_machine :status, :initial => :inactive do

    event :activate do
      transition :inactive => :active
    end

    event :block do
      transition :all => :blocked
    end

    event :unblock do
      transition :blocked => :active
    end

    event :lock do
      transition :all => :locked
    end

    event :unlock do
      transition :locked => :active
    end

  end

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> admin.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("
                                            LOWER(name) LIKE LOWER('%#{query}%') OR\
                                            LOWER(username) LIKE LOWER('%#{query}%') OR\
                                            LOWER(status) LIKE LOWER('%#{query}%') OR\
                                            LOWER(email) LIKE LOWER('%#{query}%') OR\
                                            LOWER(phone) LIKE LOWER('%#{query}%') OR\
                                            LOWER(address) LIKE LOWER('%#{query}%')")
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
    exclusion_list += ConfigCenter::Admin::EXCLUDED_JSON_ATTRIBUTES
    options[:except] ||= exclusion_list
    super(options)
  end

  def display_status
    ConfigCenter::Admin::STATUS_LIST[status]
  end


  include StateMachinesScopes

end
