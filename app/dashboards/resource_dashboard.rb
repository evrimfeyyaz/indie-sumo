require "administrate/base_dashboard"

class ResourceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    categories: Field::HasMany,
    lists: Field::HasMany,
    list_items: Field::HasMany,
    information_recommendations: Field::HasMany,
    creators: Field::HasMany,
    icon: ActiveStorageField,
    comments: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    website: Field::String,
    twitter: Field::String,
    facebook: Field::String,
    github: Field::String,
    youtube: Field::String,
    slug: Field::String,
    footnote: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :icon,
    :title,
    :description
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :title,
    :icon,
    :slug,
    :description,
    :website,
    :twitter,
    :facebook,
    :github,
    :youtube,
    :footnote,
    :categories,
    :creators,
    :lists,
    :information_recommendations,
    :comments,
    :created_at,
    :updated_at,
    :id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :slug,
    :icon,
    :description,
    :website,
    :twitter,
    :facebook,
    :github,
    :youtube,
    :footnote,
    :categories,
    :creators
  ].freeze

  # Overwrite this method to customize how resources are displayed
  # across all pages of the admin dashboard.
  def display_resource(resource)
    resource.title
  end
end
