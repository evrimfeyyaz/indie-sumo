# Create categories and resources
15.times do
  category_title       = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create(title: category_title, description: category_description)

  10.times do
    resource_title       = Faker::Fallout.character
    resource_description = Faker::Fallout.quote

    links_url = 'http://www.example.com'

    Resource.create(title:       resource_title,
                    description: resource_description,
                    categories:  [category],
                    website:     links_url,
                    twitter:     links_url,
                    github:      links_url,
                    youtube:     links_url,
                    facebook:    links_url)
  end
end

p "Created #{Category.count} categories"
p "Created #{Resource.count} resources"