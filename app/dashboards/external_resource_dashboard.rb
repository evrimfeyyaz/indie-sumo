require "administrate/base_dashboard"

class ExternalResourceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    list_items: Field::HasMany,
    icon_attachment: Field::HasOne,
    icon_blob: Field::HasOne,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :list_items,
    :icon_attachment,
    :icon_blob,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :list_items,
    :icon_attachment,
    :icon_blob,
    :id,
    :title,
    :description,
    :url,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :list_items,
    :icon_attachment,
    :icon_blob,
    :title,
    :description,
    :url,
  ].freeze

  # Overwrite this method to customize how external resources are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(external_resource)
  #   "ExternalResource ##{external_resource.id}"
  # end
end
