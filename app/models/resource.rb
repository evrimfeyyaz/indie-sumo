class Resource < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :lists
  has_many :list_items, as: :listable

  validates_presence_of :title
end
