class CreateResourceRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_recommendations do |t|
      t.string :recommender_name
      t.string :recommender_email
      t.string :name
      t.string :website
      t.string :other_information

      t.timestamps
    end
  end
end
