class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env['omniauth.auth']

    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = auth

      render 'users/required_information'
    end
  end

  def finish_oauth_authentication
    auth = session['devise.facebook_data']
    username = params[:user][:username]
    email = params[:user][:email]

    @user = User.from_omniauth(auth)
    @user.username = username
    @user.email = email if email.present?

    if @user.save
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      render 'users/required_information'
    end
  end

  def failure
    redirect_to root_path
  end
end