require 'rails_helper'

describe Item do
  it { should have_and_belong_to_many(:categories) }
  it { should validate_presence_of(:title) }
end
