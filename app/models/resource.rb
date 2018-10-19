class Resource < ApplicationRecord
  after_save :touch_categories

  default_scope { order(title: :asc) }

  include Sluggable

  has_and_belongs_to_many :categories,
                          after_add:    :touch_updated_at,
                          after_remove: :touch_updated_at
  has_many :lists, dependent: :destroy,
           after_add:         :touch_updated_at,
           after_remove:      :touch_updated_at
  has_many :information_recommendations, dependent: :destroy
  has_many :creators, dependent: :destroy,
           after_add:            :touch_updated_at,
           after_remove:         :touch_updated_at
  has_one_attached :icon
  has_many :comments, dependent: :destroy,
           after_add:            :touch_updated_at,
           after_remove:         :touch_updated_at

  searchkick word_start:  [:title, :description, :categories],
             word_middle: [:links]

  validates_presence_of :title

  # TODO: Test the search data
  def search_data
    {
      title:       title,
      description: description,
      links:       links_as_string,
      categories:  categories_as_string
    }
  end

  def links_as_string
    links = []

    links.push("Website: #{website}") if website.present?
    links.push("Twitter: #{twitter}") if twitter.present?
    links.push("GitHub: #{github}") if github.present?
    links.push("YouTube: #{youtube}") if youtube.present?

    links.join(', ')
  end

  def categories_as_string
    'Categories: ' + categories.map(&:title).join(', ')
  end

  private

    # TODO: Move this into a module with `method_missing`.
    def touch_categories
      categories.find_each(&:touch)
    end

    def touch_updated_at(_)
      self.touch if persisted?
    end
end