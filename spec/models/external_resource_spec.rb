require 'rails_helper'

describe ExternalResource  do
  it { should have_many(:list_items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
