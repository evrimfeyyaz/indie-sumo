class ResourceRecommendation < ApplicationRecord
  belongs_to :category

  validates_presence_of :name
  validates_presence_of :website
end
