class DropInformationRecommendations < ActiveRecord::Migration[5.2]
  def change
    drop_table :information_recommendations
  end
end
