require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Category do
  it_behaves_like 'a sluggable'

  it { should have_many(:resources) }
  it { should validate_presence_of(:title) }
end
