class RemoveListFromExternalResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :external_resources, :list_id
  end
end
