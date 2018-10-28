class ExternalResource < ApplicationRecord
  after_save :touch_resources_that_reference_it_as_list_item

  has_many :list_items, as: :listable, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title

  private

    def touch_resources_that_reference_it_as_list_item
      Resource
        .joins(:list_items)
        .where('list_items.listable': self)
        .update_all(updated_at: Time.now)
    end
end
