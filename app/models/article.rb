class Article < ApplicationRecord
	has_and_belongs_to_many :diseases

	include Imageable

	validates :title, presence: true, length: { minimum: 3, maximum: 80 }
end