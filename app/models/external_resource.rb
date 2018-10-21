class ExternalResource < ApplicationRecord
  after_save :touch_list_items_referencing_it

  has_many :list_items, as: :listable, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title

  private

    def touch_list_items_referencing_it
      ListItem.where(listable: self)
        .update_all(updated_at: Time.now)
    end
end
