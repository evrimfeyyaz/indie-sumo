p 'Seeding the database...'

# Create categories.
15.times do
  category_title       = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create!(title: category_title, description: category_description)

  icon_no  = rand(0..5)

  if icon_no > 0
    icon_path = File.join(Rails.root, "/app/assets/images/seed/category_icons/#{icon_no}.png")
    category.icon.attach(io: File.open(icon_path), filename: "#{category.title.parameterize}.png")
  end

  # Add resources to the category.
  10.times do
    resource_title       = Faker::Fallout.character
    resource_description = Faker::Fallout.quote

    links_url = 'http://www.example.com'

    resource = Resource.create!(title:       resource_title,
                                description: resource_description,
                                categories:  [category],
                                website:     links_url,
                                twitter:     links_url,
                                github:      links_url,
                                youtube:     links_url,
                                facebook:    links_url)

    icon_no  = rand(0..5)

    if icon_no > 0
      icon_path = File.join(Rails.root, "/app/assets/images/seed/resource_icons/#{icon_no}.jpg")
      resource.icon.attach(io: File.open(icon_path), filename: "#{resource.title.parameterize}.jpg")
    end

    # Add lists to the resource.
    3.times do
      list_title = Faker::Fallout.faction

      list = List.create!(title:    list_title,
                          resource: resource)

      # Add a regular resource to the list.
      resource = Resource.order("RANDOM()").first
      ListItem.create(listable: resource, list: list)

      # Add external resources to the list.
      3.times do
        external_resource_title       = Faker::Fallout.character
        external_resource_description = Faker::Fallout.quote
        external_resource_url         = 'http://www.example.com'

        external_resource = ExternalResource.create!(title:       external_resource_title,
                                                     description: external_resource_description,
                                                     url:         external_resource_url)
        ListItem.create(listable: external_resource, list: list)

        icon_no  = rand(0..5)

        if icon_no > 0
          icon_path = File.join(Rails.root, "/app/assets/images/seed/resource_icons/#{icon_no}.jpg")
          external_resource.icon.attach(io: File.open(icon_path), filename: "#{resource.title.parameterize}.jpg")
        end
      end
    end
  end
end

p "Created #{Category.count} categories"
p "Created #{Resource.count} resources"
p "Created #{List.count} lists"
p "Created #{ExternalResource.count} external resources"