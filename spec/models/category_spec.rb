require 'rails_helper'

describe Category do
  it { should have_and_belong_to_many(:resources) }
  it { should validate_presence_of(:title) }
end
