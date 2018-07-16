require 'rails_helper'

describe List do
  it { should belong_to(:resource) }
  it { should have_many(:external_resources) }
  it { should validate_presence_of(:title) }
end