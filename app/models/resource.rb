class Resource < ApplicationRecord
  after_save :touch_resources_that_reference_it_as_list_item,
             :touch_categories

  default_scope { order(title: :asc) }

  include Sluggable

  has_and_belongs_to_many :categories,
                          after_add:    :touch_updated_at,
                          after_remove: :touch_updated_at
  has_many :lists, dependent: :destroy
  has_many :list_items, through: :lists
  has_many :information_recommendations, dependent: :destroy
  has_one_attached :icon
  has_many :comments, dependent: :destroy

  searchkick word_start:  [:title, :description, :categories],
             word_middle: [:website]

  validates_presence_of :title

  # TODO: Test the search data
  def search_data
    {
      title:       title,
      description: description,
      website:     website,
      categories:  categories_as_string
    }
  end

  def categories_as_string
    'Categories: ' + categories.map(&:title).join(', ')
  end

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