require 'rails_helper'

describe Resource do
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists) }
  it { should have_many(:list_items) }
  it { should validate_presence_of(:title) }
end
