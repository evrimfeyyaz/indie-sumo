class ApplicationController < ActionController::Base
  etag { APP_SETTINGS['app_version'] }
end
