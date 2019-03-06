NUM_OF_CATEGORIES             = 15
NUM_OF_RESOURCES_PER_CATEGORY = 25

total_resources = NUM_OF_CATEGORIES * NUM_OF_RESOURCES_PER_CATEGORY

p 'Removing existing images...'
if Rails.env.production?
  s3     = Aws::S3::Resource.new(access_key_id: Rails.application.credentials.dig(:aws, :access_key_id), secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key), region: ENV['S3_REGION'])
  bucket = s3.bucket(ENV['S3_BUCKET'])
  bucket.clear!
else
  FileUtils.rm_rf(Dir['storage/*'])
end

p 'Seeding the database...'
p 'Creating resources...'

# Create categories.
NUM_OF_CATEGORIES.times do |category_index|
  category_title = Faker::Fallout.faction

  category = Category.create!(title: category_title)

  icon_no = rand(1..10)

  if icon_no.between?(1, 5) # 50% chance of getting an icon.
    icon_path = File.join(Rails.root, "/seed/category_icons/#{icon_no}.png")
    category.icon.attach(io: File.open(icon_path), filename: "#{category.title.parameterize}.png")
  end

  # Add resources to the category.
  NUM_OF_RESOURCES_PER_CATEGORY.times do |resource_index|
    resource_title       = Faker::Fallout.character
    resource_description = Faker::Fallout.quote

    website = 'http://www.example.com'

    resource = Resource.create!(title:       resource_title,
                                description: resource_description,
                                category:    category,
                                website:     website)

    icon_no = rand(1..25)

    if icon_no.between?(1, 5) # 20% chance of getting an icon.
      icon_path = File.join(Rails.root, "/seed/resource_icons/#{icon_no}.jpg")
      resource.icon.attach(io: File.open(icon_path), filename: "#{resource.title.parameterize}.jpg")
    end

    # Add comments to the resource
    2.times do
      Comment.create!(name:     Faker::Fallout.character,
                      email:    Faker::Internet.email,
                      comment:  Faker::Fallout.quote,
                      resource: resource,
                      approved: true)
    end

    num_of_created_resources = (resource_index + 1) + (NUM_OF_RESOURCES_PER_CATEGORY * category_index)
    print "#{(num_of_created_resources / total_resources.to_f * 100).to_i}% done.\r"
  end
end

p 'Creating resource associations...'
# Add resource associations.
resource_ids = Resource.ids

100.times do
  referencing_resource = resource_ids.sample
  referenced_resource  = resource_ids.sample

  ResourceAssociation.create(resource_id:       referencing_resource,
                             resourceable_id:   referenced_resource,
                             resourceable_type: 'Resource')
end

p 'Creating external resources...'
# Create external resources and associate them to random resources.
100.times do
  external_resource_title = Faker::Fallout.character
  external_resource_url   = 'http://www.example.com'

  ExternalResource.create!(title: external_resource_title,
                           url:   external_resource_url)
end

p 'Creating external resource associations...'

external_resource_ids = ExternalResource.ids
100.times do
  referencing_resource         = resource_ids.sample
  referenced_external_resource = external_resource_ids.sample

  ResourceAssociation.create(resource_id:       referencing_resource,
                             resourceable_id:   referenced_external_resource,
                             resourceable_type: 'ExternalResource')
end

# Create an admin user.
User.create!(email: 'admin@example.com', password: '123456')

p "Created #{Category.count} categories."
p "Created #{Resource.count} resources."
p "Created #{ExternalResource.count} external resources."
p "Created #{ResourceAssociation.count} resource associations."