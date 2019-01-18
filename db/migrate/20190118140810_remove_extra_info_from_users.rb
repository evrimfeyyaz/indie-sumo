class RemoveExtraInfoFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bio, :string
    remove_column :users, :twitter_handle, :string
    remove_column :users, :facebook_handle, :string
    remove_column :users, :instagram_handle, :string
    remove_column :users, :google_plus_handle, :string
    remove_column :users, :youtube_handle, :string
    remove_column :users, :github_handle, :string
    remove_column :users, :website_url, :string
    remove_column :users, :indie_hackers_handle, :string
    remove_column :users, :product_hunt_handle, :string
    remove_column :users, :username, :string
    remove_column :users, :admin, :string
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
