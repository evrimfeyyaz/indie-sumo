require 'rails_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_most(64) }
end
