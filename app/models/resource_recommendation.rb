class ResourceRecommendation < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :website
end
