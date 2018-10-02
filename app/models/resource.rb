class Resource < ApplicationRecord
  default_scope { order(title: :asc) }

  include Sluggable

  has_and_belongs_to_many :categories
  has_many :lists, dependent: :destroy
  has_many :information_recommendations, dependent: :destroy
  has_many :creators, dependent: :destroy
  has_one_attached :icon
  has_many :comments, dependent: :destroy

  searchkick word_start: [:title, :description, :categories],
             word_middle: [:links]

  validates_presence_of :title

  # TODO: Test the search data
  def search_data
    {
      title: title,
      description: description,
      links: links_as_string,
      categories: categories_as_string
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
end