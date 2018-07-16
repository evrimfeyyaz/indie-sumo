class ExternalResource < ApplicationRecord
  has_many :list_items, as: :listable

  validates_presence_of :title
end
