class Offering < ActiveRecord::Base

  # Validations
  validates :name,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::NAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::NAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::NAME_FORMAT_REG_EXP}

  validates :price, presence: true, :numericality => {:greater_than => 0}
  validates :deity, presence: true
  validates :temple, presence: true

  validates :devaswam_share, presence: true
  validates :shanti_share, presence: true
  validates :kazhakam_share, presence: true

  validate :sum_of_shares

  def sum_of_shares
    if devaswam_share.present? && shanti_share.present? && kazhakam_share.present?
      if devaswam_share + shanti_share + kazhakam_share != price
        errors.add(:price, "doesn't match with the sum of Devaswam, Shanti and Kazhakam share")
      end
    end
  end

  def display_name
    unicode_name || name
  end

  # Associations
  belongs_to :deity
  belongs_to :temple

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> offering.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR\ LOWER(notes) LIKE LOWER('%#{query}%')") }

end
