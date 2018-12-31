def get_oauth_hash
  {
    provider: 'facebook',
    uid:      '123456',
    info:     {
      name:  'John Doe',
      email: 'johndoe@example.com'
    }
  }
end

RSpec.configure do |config|
  config.before(:example, :oauth) do
    oauth_hash = get_oauth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(oauth_hash)

    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
  end

  config.before(:example, :oauth_no_email) do
    oauth_hash = get_oauth_hash
    oauth_hash[:info][:email] = nil
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(oauth_hash)

    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
  end

  config.after(:example, :oauth) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end
end

OmniAuth.config.test_mode = true

