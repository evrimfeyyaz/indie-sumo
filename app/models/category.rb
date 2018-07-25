class Category < ApplicationRecord
  include Sluggable

  has_and_belongs_to_many :resources
  has_many :resource_recommendations, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title
end
