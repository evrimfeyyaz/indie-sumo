# Create categories and items
15.times do
  category_title = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create(title: category_title, description: category_description)

  10.times do
    item_title = Faker::Fallout.character
    item_description = Faker::Fallout.quote

    links_url = 'http://www.example.com'

    Item.create(title: item_title,
                description: item_description,
                category: category,
                website: links_url,
                twitter: links_url,
                github: links_url,
                youtube: links_url,
                facebook: links_url)
  end
end

p "Created #{Category.count} categories"
p "Created #{Item.count} items"