class CreateExternalResources < ActiveRecord::Migration[5.2]
  def change
    create_table :external_resources do |t|
      t.string :title
      t.text :description
      t.string :url
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
