class AddSlugsToCategories < ActiveRecord::Migration[5.2]
  def change
    # Recreate an empty database before this migration.
    add_column :categories, :slug, :string, null: false
    add_index :categories, :slug, unique: true
  end
end
