require 'rails_helper'

describe ExternalResource  do
  it { should belong_to(:list) }
  it { should validate_presence_of(:title) }
end
