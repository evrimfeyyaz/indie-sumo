require 'rails_helper'

describe Category do
  it { should have_and_belong_to_many(:resources) }
  it { should have_many(:resource_recommendations) }
  it { should validate_presence_of(:title) }
end
