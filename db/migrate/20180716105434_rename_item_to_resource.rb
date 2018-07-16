class RenameItemToResource < ActiveRecord::Migration[5.2]
  def change
    rename_table :items, :resources
    rename_table :categories_items, :categories_resources
    rename_column :categories_resources, :item_id, :resource_id
  end
end
