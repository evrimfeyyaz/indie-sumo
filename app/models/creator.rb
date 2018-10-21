class Creator < ApplicationRecord
  belongs_to :resource # Owner resource
  belongs_to :referenced_resource, class_name: 'Resource', optional: true

  validates_presence_of :name

  def name
    referenced_resource&.title || self[:name]
  end

  def url
    return Rails.application.routes.url_helpers.resource_path(referenced_resource) if referenced_resource.present?

    self[:url]
  end
end
