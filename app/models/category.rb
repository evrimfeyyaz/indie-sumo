class Category < ApplicationRecord
  after_commit :reindex_resources
  after_save :touch_resources

  default_scope { order(title: :asc) }

  include Sluggable

  has_and_belongs_to_many :resources,
                          after_add:    :touch_updated_at,
                          after_remove: :touch_updated_at
  has_many :resource_recommendations, dependent: :destroy
  has_one_attached :icon

  validates_presence_of :title

  private

    def reindex_resources
      resources.each do |resource|
        resource.reindex
      end
    end

    def touch_resources
      resources.find_each(&:touch)
    end

    def touch_updated_at(_)
      self.touch if persisted?
    end
end
