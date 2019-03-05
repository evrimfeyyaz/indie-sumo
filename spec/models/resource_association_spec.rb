require 'rails_helper'

describe ResourceAssociation do
  it { should belong_to(:resource).touch(:true) }
  it { should belong_to(:resourceable).touch(:true) }
  it { should validate_uniqueness_of(:resource_id).scoped_to(:resourceable_id, :resourceable_type) }
end
