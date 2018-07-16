class CreateListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :list_items do |t|
      t.references :listable, polymorphic: true
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
