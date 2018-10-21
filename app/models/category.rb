class Category < ApplicationRecord
  after_commit :reindex_resources

  default_scope { order(title: :asc) }

  include Sluggable

  has_and_belongs_to_many :resources
  has_many :resource_recommendations, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title

  private

    def reindex_resources
      resources.each do |resource|
        resource.reindex
      end
    end
end
