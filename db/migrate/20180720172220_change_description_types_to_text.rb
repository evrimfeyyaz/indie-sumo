class ChangeDescriptionTypesToText < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :description, :text
    change_column :resources, :description, :text
  end
end
