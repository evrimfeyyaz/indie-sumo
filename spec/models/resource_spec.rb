require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:information_recommendations).dependent(:destroy) }
  it { should have_many(:creators).dependent(:destroy) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:title) }
end
