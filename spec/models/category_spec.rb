require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Category do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:resources) }
  it { should have_many(:resource_recommendations).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
