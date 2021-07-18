class Collection < ApplicationRecord
  before_create :generate_slug
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :cards
  has_many :card_sets

  private
  def generate_slug
    self.slug = self.name.downcase.parameterize
  end
end
