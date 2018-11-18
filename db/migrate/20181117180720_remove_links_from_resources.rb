class RemoveLinksFromResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :resources, :website, :string
    remove_column :resources, :twitter, :string
    remove_column :resources, :facebook, :string
    remove_column :resources, :github, :string
    remove_column :resources, :youtube, :string
  end
end
