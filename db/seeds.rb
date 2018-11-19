NUM_OF_CATEGORIES             = 15
NUM_OF_RESOURCES_PER_CATEGORY = 25

total_resources = NUM_OF_CATEGORIES * NUM_OF_RESOURCES_PER_CATEGORY

p 'Emptying the storage folder...'
FileUtils.rm_rf(Dir['storage/*'])

p 'Seeding the database...'

# Create categories.
NUM_OF_CATEGORIES.times do |category_index|
  category_title       = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create!(title: category_title,
                              description: category_description)

  icon_no = rand(1..10)

  if icon_no.between?(1, 5) # 50% chance of getting an icon.
    icon_path = File.join(Rails.root, "/app/assets/images/seed/category_icons/#{icon_no}.png")
    category.icon.attach(io: File.open(icon_path), filename: "#{category.title.parameterize}.png")
  end

  # Add resources to the category.
  NUM_OF_RESOURCES_PER_CATEGORY.times do |resource_index|
    resource_title       = Faker::Fallout.character
    resource_description = Faker::Fallout.quote

    website = 'http://www.example.com'
    footnote  = 'Image copyright <a href="http://www.example.com">John Doe</a>.'

    resource = Resource.create!(title:       resource_title,
                                description: resource_description,
                                categories:  [category],
                                website:     website,
                                footnote:    footnote)

    icon_no = rand(1..25)

    if icon_no.between?(1, 5) # 20% chance of getting an icon.
      icon_path = File.join(Rails.root, "/app/assets/images/seed/resource_icons/#{icon_no}.jpg")
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

    # Add lists to the resource.
    2.times do
      list_title = Faker::Fallout.faction

      list = List.create!(title:    list_title,
                          resource: resource)

      # Add an internal resource to the list.
      internal_resource = Resource.order("RANDOM()").first
      ListItem.create(listable: internal_resource, list: list)

      # Add external resources to the list.
      2.times do
        external_resource_title       = Faker::Fallout.character
        external_resource_description = Faker::Fallout.quote
        external_resource_url         = 'http://www.example.com'

        external_resource = ExternalResource.create!(title:       external_resource_title,
                                                     description: external_resource_description,
                                                     url:         external_resource_url)
        ListItem.create(listable: external_resource, list: list)

        # We don't want too many of these having icons, as there are more than 1000 of them.
        if resource_index == 1
          icon_path = File.join(Rails.root, "/app/assets/images/seed/resource_icons/#{rand(1..5)}.jpg")
          external_resource.icon.attach(io: File.open(icon_path), filename: "#{resource.title.parameterize}.jpg")
        end
      end
    end

    num_of_created_resources = (resource_index + 1) + (NUM_OF_RESOURCES_PER_CATEGORY * category_index)
    print "#{(num_of_created_resources / total_resources.to_f * 100).to_i}% done.\r"
  end
end

# Make the last category coming soon.
Category.last.update(coming_soon: true)

# Reindex search results.
Resource.reindex

p "Created #{Category.count} categories"
p "Created #{Resource.count} resources"
p "Created #{List.count} lists"
p "Created #{ExternalResource.count} external resources"