class DropResourceRecommendations < ActiveRecord::Migration[5.2]
  def change
    drop_table :resource_recommendations
  end
end
