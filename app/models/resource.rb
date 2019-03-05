class Resource < ApplicationRecord
  after_save :touch_categories

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
  has_one_attached :icon
  has_many :comments, dependent: :destroy
  has_many :resource_associations, dependent: :destroy
  has_many :related_resources, through: :resource_associations, source: :resourceable, source_type: 'Resource'
  has_many :related_external_resources, through: :resource_associations, source: :resourceable, source_type: 'ExternalResource'

  validates_presence_of :title

  def associated_resources
    related_resources +
      related_external_resources +
      Resource.joins(:resource_associations)
        .where("resource_associations.resourceable_type = ? AND resource_associations.resourceable_id = ?", 'Resource', self.id)
  end

  private

    def touch_categories
      categories.find_each(&:touch)
    end

    def touch_updated_at(_)
      self.touch if persisted?
    end
end