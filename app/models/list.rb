class List < ApplicationRecord
  belongs_to :resource
  has_many :external_resources

  validates_presence_of :title
end
