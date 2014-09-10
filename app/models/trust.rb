class Trust < ActiveRecord::Base

  # Validations
  validates :name,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::NAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::NAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::NAME_FORMAT_REG_EXP}

  validates :status, :presence=> true, :inclusion => { :in => ConfigCenter::Admin::STATUS_LIST.keys }

  validates :email,
    :uniqueness => {:case_sensitive => false},
    :format => {:with => ConfigCenter::GeneralValidations::EMAIL_FORMAT_REG_EXP},
    :unless => proc{|trust| trust.email.blank? }

  validates :address,
    :presence => true,
    :length => {:minimum => ConfigCenter::Trust::ADDRESS_MIN_LEN ,
      :maximum => ConfigCenter::Trust::ADDRESS_MAX_LEN}

  # Associations
  has_many :admins

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
  #   >>> trust.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("
                                            LOWER(name) LIKE LOWER('%#{query}%') OR\
                                            LOWER(status) LIKE LOWER('%#{query}%') OR\
                                            LOWER(email) LIKE LOWER('%#{query}%') OR\
                                            LOWER(phone) LIKE LOWER('%#{query}%') OR\
                                            LOWER(address) LIKE LOWER('%#{query}%')")
                        }

  def display_status
    ConfigCenter::Trust::STATUS_LIST[status]
  end

end
