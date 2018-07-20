class CreateInformationRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :information_recommendations do |t|
      t.string :recommender_name
      t.string :recommender_email
      t.text :information
      t.references :resource, foreign_key: true

      t.timestamps
    end
  end
end
