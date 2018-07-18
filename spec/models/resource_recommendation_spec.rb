require 'rails_helper'

describe ResourceRecommendation do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:website) }
end
