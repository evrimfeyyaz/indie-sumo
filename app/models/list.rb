class List < ApplicationRecord
  belongs_to :resource
  has_many :list_items, dependent: :destroy

  validates_presence_of :title

  def items
    list_items.map(&:listable).sort_by { |listable| listable.title }
  end
end