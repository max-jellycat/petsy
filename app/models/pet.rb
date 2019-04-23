class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species, counter_cache: true

  validates :name, :gender, :birthday, presence: true
  validates :gender, format: { with: /\A(M|F|H)\z/ }
  validates :avatar_file, presence: true, on: :create
  validate :birthday_not_future

  has_image :avatar, resize: 500
  
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
