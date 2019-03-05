require "administrate/base_dashboard"

class ResourceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    categories:                 Field::HasMany,
    related_resources:          Field::HasMany.with_options(class_name: 'Resource'),
    related_external_resources: Field::HasMany.with_options(class_name: 'ExternalResource'),
    icon:                       ActiveStorageField,
    comments:                   Field::HasMany,
    id:                         Field::Number,
    title:                      Field::String,
    description:                Field::Text,
    created_at:                 Field::DateTime,
    updated_at:                 Field::DateTime,
    website:                    Field::String,
    slug:                       Field::String
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
    :categories,
    :related_resources,
    :related_external_resources,
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
    :categories,
    :related_resources,
    :related_external_resources,
  ].freeze

  # Overwrite this method to customize how resources are displayed
  # across all pages of the admin dashboard.
  def display_resource(resource)
    resource.title
  end
end
