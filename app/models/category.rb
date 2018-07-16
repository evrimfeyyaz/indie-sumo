class Category < ApplicationRecord
  has_and_belongs_to_many :resources

  validates_presence_of :title
end
