class ExternalResource < ApplicationRecord
  has_many :list_items, as: :listable, dependent: :destroy

  validates_presence_of :title
end
