class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species

  validates :name, :gender, :birthday, presence: true
  validates :gender, format: { with: /\A(M|F|H)\z/ }
  validate :birthday_not_future
  
  def birthday_not_future
    if birthday.present? && birthday.future?
      errors.add(:birthday, "can't be in the future")
    end
  end

  def get_age
    ((Time.zone.now - birthday.to_time) / 1.year.seconds).floor
  end

  def get_gender
    case gender
    when 'M'
      return 'Male'
    when 'F'
      return 'Female'
    when 'H'
      return 'Hermaphrodite'
    else
      return 'EXTERMINATE'
    end
  end

  def get_species
    Species.find(species_id).name
  end
end
