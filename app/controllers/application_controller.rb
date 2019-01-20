class ApplicationController < ActionController::Base
  etag { heroku_version }

  private

  def heroku_version
    ENV['HEROKU_RELEASE_VERSION'] if Rails.env == 'production'
  end
end