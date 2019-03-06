class Category < ApplicationRecord
  default_scope { order(title: :asc) }

  include Sluggable

  has_many :resources
  has_one_attached :icon

  validates_presence_of :title
end
