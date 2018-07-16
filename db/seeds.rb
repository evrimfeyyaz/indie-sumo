15.times do
  category_title       = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create!(title: category_title, description: category_description)

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

    3.times do
      list_title = Faker::Fallout.faction

      list = List.create!(title:    list_title,
                          resource: resource)

      3.times do
        external_resource_title       = Faker::Fallout.character
        external_resource_description = Faker::Fallout.quote
        external_resource_url         = 'http://www.example.com'

        ExternalResource.create!(title:       external_resource_title,
                                 description: external_resource_description,
                                 url:         external_resource_url,
                                 list:        list)
      end
    end
  end
end

p "Created #{Category.count} categories"
p "Created #{Resource.count} resources"
p "Created #{List.count} lists"
p "Created #{ExternalResource.count} external resources"