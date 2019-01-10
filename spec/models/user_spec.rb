require 'rails_helper'

describe User do
  describe 'Validations' do
    subject { create(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_most(24) }
  end
end