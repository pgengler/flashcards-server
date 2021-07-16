class Collection < ApplicationRecord
  before_create :generate_slug
  validates_presence_of :name
  validates_uniqueness_of :name

  private
  def generate_slug
    self.slug = self.name.downcase.dasherize
  end
end
