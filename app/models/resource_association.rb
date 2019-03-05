class ResourceAssociation < ApplicationRecord
  belongs_to :resource, touch: true
  belongs_to :resourceable, polymorphic: true, touch: true

  validates_uniqueness_of :resource_id, scope: [:resourceable_id, :resourceable_type]
end