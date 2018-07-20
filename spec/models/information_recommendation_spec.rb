require 'rails_helper'

describe InformationRecommendation do
  it { should belong_to(:resource) }
  it { should validate_presence_of(:information) }
end
