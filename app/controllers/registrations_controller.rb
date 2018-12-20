class RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :username, :email,
                                   :password, :password_confirmation, :twitter_handle,
                                   :facebook_handle, :github_handle, :youtube_handle,
                                   :instagram_handle, :google_plus_handle, :website_url,
                                   :indie_hackers_handle, :product_hunt_handle, :bio)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :username, :email,
                                   :password, :password_confirmation, :twitter_handle,
                                   :facebook_handle, :github_handle, :youtube_handle,
                                   :instagram_handle, :google_plus_handle, :website_url,
                                   :indie_hackers_handle, :product_hunt_handle, :bio)
    end
end