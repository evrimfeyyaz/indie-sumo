class List < ApplicationRecord
  belongs_to :resource
  has_many :list_items

  validates_presence_of :title

  def items
    list_items.map(&:listable)
  end
end