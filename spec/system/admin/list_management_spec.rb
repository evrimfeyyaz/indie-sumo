require 'rails_helper'

describe 'Admin list management' do
  include Devise::Test::IntegrationHelpers

  let(:admin) { create(:user) }

  scenario 'An admin can add any resource or external resource to a list' do
    list = create(:list)

    sign_in admin

    visit admin_root_url

    click_link 'Lists'
    click_link 'Edit'
  end
end