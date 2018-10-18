RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  Capybara::Webkit.configure do |config|
    config.block_unknown_urls
  end
end
