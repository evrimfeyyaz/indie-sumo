class AddComingSoonToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :coming_soon, :boolean, default: false
  end
end
