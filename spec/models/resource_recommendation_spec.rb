require 'rails_helper'

describe ResourceRecommendation do
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:website) }
end