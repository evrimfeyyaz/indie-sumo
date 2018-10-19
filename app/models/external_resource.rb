class ExternalResource < ApplicationRecord
  after_save :touch_list_items_referencing_this_external_resource

  has_many :list_items, as: :listable, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title

  private

    def touch_list_items_referencing_this_external_resource
      ListItem.where(listable: self).each(&:touch)
    end
end
