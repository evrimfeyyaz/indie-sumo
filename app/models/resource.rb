class Resource < ApplicationRecord
  after_save :touch_resources_that_reference_it_as_list_item,
             :touch_categories

  default_scope { order(title: :asc) }

  include Sluggable

  include PgSearch
  pg_search_scope :search, against: {
    title:       'A',
    description: 'B'
  }, using:                         {
    tsearch: { prefix: true, any_word: true }
  }

  has_and_belongs_to_many :categories,
                          after_add:    :touch_updated_at,
                          after_remove: :touch_updated_at
  has_many :lists, dependent: :destroy
  has_many :list_items, through: :lists
  has_many :information_recommendations, dependent: :destroy
  has_one_attached :icon
  has_many :comments, dependent: :destroy

  validates_presence_of :title

  private

    def touch_resources_that_reference_it_as_list_item
      Resource
        .joins(:list_items)
        .where('list_items.listable': self)
        .update_all(updated_at: Time.now)
    end

    def touch_categories
      categories.find_each(&:touch)
    end

    def touch_updated_at(_)
      self.touch if persisted?
    end
end