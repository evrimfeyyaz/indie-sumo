class AddSlugToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :slug, :string, null: false
    add_index :resources, :slug, unique: true
  end
end
