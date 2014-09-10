class Deity < ActiveRecord::Base

  # Validations

  #validates :name, presence: true

  #validates :description, presence: true

  #validates :temple_id, presence: true, numericality: true, if: proc{|x| x.condition? }

  #validates :trust_id, presence: true, numericality: true, if: proc{|x| x.condition? }

  # Validation Examples
  #LANDLINE_LIST = ["1234567890", "0987654321"]
  #validates :first_name,
  #           presence: true,
  #           length: {minimum: ConfigCenter::GeneralValidations::FIRST_NAME_MIN_LEN ,
  #           maximum: ConfigCenter::GeneralValidations::FIRST_NAME_MAX_LEN, message: "should be less than x and greater than y"},
  #           uniqueness: {scope: [:user_id, :status], case_sensitive: false},
  #           format: {with: ConfigCenter::GeneralValidations::FIRST_NAME_FORMAT_REG_EXP, message: "Invalid format"},
  #           inclusion: { in: PHONE_LIST, message: "not included in the list" },
  #           unless: proc{|user| user.password.blank? }


  # Associations
  #belongs_to :user, foreign_key: :owner_id
  #has_many :products

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> deity.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("
                                            LOWER(name) LIKE LOWER('%#{query}%')")
                        }

end
