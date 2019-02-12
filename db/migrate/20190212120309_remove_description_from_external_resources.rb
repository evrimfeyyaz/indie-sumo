class RemoveDescriptionFromExternalResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :external_resources, :description, :text
  end
end
