class Deity < ActiveRecord::Base

  # Validations
  validates :name,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::NAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::NAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::NAME_FORMAT_REG_EXP}

  validates :temple, presence: true
  validates :trust, presence: true

  # Associations
  belongs_to :temple
  belongs_to :trust

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> deity.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR LOWER(description) LIKE LOWER('%#{query}%')") }

end
