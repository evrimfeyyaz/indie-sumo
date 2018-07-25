class ExternalResource < ApplicationRecord
  has_many :list_items, as: :listable, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title
end
