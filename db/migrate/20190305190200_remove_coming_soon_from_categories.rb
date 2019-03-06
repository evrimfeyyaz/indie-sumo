class RemoveComingSoonFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :coming_soon, :string
  end
end
