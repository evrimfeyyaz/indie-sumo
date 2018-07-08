# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create categories and items
15.times do
  category_title = Faker::Fallout.faction
  category_description = Faker::Fallout.quote

  category = Category.create(title: category_title, description: category_description)

  10.times do
    item_title = Faker::Fallout.character
    item_description = Faker::Fallout.quote

    Item.create(title: item_title, description: item_description, category: category)
  end
end

p "Created #{Category.count} categories"
p "Created #{Item.count} items"
