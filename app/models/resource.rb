class Resource < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :lists

  validates_presence_of :title
end
