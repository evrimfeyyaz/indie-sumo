class AddLinksToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :website, :string
    add_column :items, :twitter, :string
    add_column :items, :facebook, :string
    add_column :items, :github, :string
    add_column :items, :youtube, :string
  end
end
