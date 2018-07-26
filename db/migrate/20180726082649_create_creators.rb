class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators do |t|
      t.string :name
      t.string :url
      t.references :resource, foreign_key: true

      t.timestamps
    end
  end
end
