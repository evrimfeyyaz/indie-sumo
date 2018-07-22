class Resource < ApplicationRecord
  include Sluggable

  has_and_belongs_to_many :categories
  has_many :lists, dependent: :destroy
  has_many :list_items, as: :listable, dependent: :destroy
  has_many :information_recommendations, dependent: :destroy

  validates_presence_of :title
end
