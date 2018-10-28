class List < ApplicationRecord
  belongs_to :resource, touch: true
  has_many :list_items, dependent: :destroy,
           after_add:              :touch_resource,
           after_remove:           :touch_resource

  validates_presence_of :title

  def items
    list_items.map(&:listable).sort_by { |listable| listable.title }
  end

  private

    def touch_resource(_)
      resource.touch
    end
end