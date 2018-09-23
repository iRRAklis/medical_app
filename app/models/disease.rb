class Disease < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :articles

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :probability, presence: true, numericality: { only_integer: false }
end
