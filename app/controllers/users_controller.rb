class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  before_action :require_own_profile

  def show
  end

  private

    def set_user
      @user ||= User.find_by!(username: params[:username])
    end

    def require_own_profile
      render status: 404 unless current_user == @user
    end
end