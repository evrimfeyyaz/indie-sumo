class InformationRecommendation < ApplicationRecord
  belongs_to :resource

  validates_presence_of :information
end
