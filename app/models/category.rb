class Category < ApplicationRecord
  include Sluggable

  has_and_belongs_to_many :resources
  has_many :resource_recommendations, dependent: :destroy

  validates_presence_of :title
end
