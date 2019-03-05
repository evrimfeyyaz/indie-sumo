class ExternalResource < ApplicationRecord
  has_one_attached :icon

  validates_presence_of :title
end
