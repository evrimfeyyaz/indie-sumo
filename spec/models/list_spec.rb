require 'rails_helper'

describe List do
  it { should belong_to(:resource) }
  it { should have_many(:list_items).dependent(:destroy) }
  it { should validate_presence_of(:title) }

  describe '#items' do
    subject {
      resource = create(:resource)
      create(:list, resource: resource)
    }

    it 'returns all listables' do
      resource = create(:resource)
      external_resource = create(:external_resource)

      create(:list_item, listable: resource, list: subject)
      create(:list_item, listable: external_resource, list: subject)

      expect(subject.items).to match_array([resource, external_resource])
    end
  end
end