class AddPersonalFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    User.destroy_all

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string, null: false
    add_column :users, :bio, :text
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :twitter_handle, :string
    add_column :users, :facebook_handle, :string
    add_column :users, :instagram_handle, :string
    add_column :users, :google_plus_handle, :string
    add_column :users, :youtube_handle, :string
    add_column :users, :github_handle, :string
    add_column :users, :website_url, :string
    add_column :users, :indie_hackers_handle, :string
    add_column :users, :product_hunt_handle, :string
    add_index :users, :username, unique: true
  end
end
