require 'rails_helper'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:information_recommendations).dependent(:destroy) }
  it { should have_many(:creators).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
