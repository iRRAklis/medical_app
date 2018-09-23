class User < ApplicationRecord
  include Imageable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  acts_as_token_authenticatable

  has_ancestry

  has_and_belongs_to_many :diseases

  validates :full_name,
            presence: true,
            length: { minimum: 3, maximum: 25 }
  validates :amka,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true },
            length: { is: 11 }, if: :amka_present?
  validates :father_amka, numericality: { only_integer: true },
            length: { is: 11 },
            allow_blank: true
  validates :mother_amka, numericality: { only_integer: true },
            length: { is: 11 },
            allow_blank: true
  validates :gender, presence: true
  validate  :same_amka_as_parents?

  HUMANIZED_ATTRIBUTES = {
    amka: "SSN",
    father_amka: "Father SSN",
    mother_amka: "Mother SSN"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def parent_diseases
  	parent_diseases = []
    
    parent_diseases << father.diseases if father.present?
    parent_diseases << mother.diseases if mother.present?

    (parent_diseases.flatten - diseases).uniq
  end

  def disease_probability
  	diseases = []

	  parent_diseases.each do |disease|
	  	diseases << { disease: disease.name, probability: disease.probability }
	  end

  	diseases
  end

  def father
    User.find_by(amka: father_amka) unless father_amka.blank?
  end

  def mother
    User.find_by(amka: mother_amka) unless mother_amka.blank?
  end

  def siblings
    return [] if father_amka.blank? && mother_amka.blank?
    User.where.not(amka: amka).where(father_amka: father_amka, mother_amka: mother_amka)
  end

  def suggested_articles
    Article.includes(:diseases).select { |article| (article.disease_ids & self.disease_ids).present? }
  end

  private
    def amka_present?
      amka.present?
    end

    def same_amka_as_parents?
      if father_amka.present? && father_amka.strip == amka.strip
        errors.add(:father_amka, " and your SSN cannot be the same.")
      elsif mother_amka.present? && mother_amka.strip == amka.strip
        errors.add(:mother_amka, " and your SSN cannot be the same.")
      elsif father_amka.present? && mother_amka.present? && father_amka.strip == mother_amka.strip
        errors.add(:father_amka, " and mother SSN cannot be the same.")
      end
    end
end
