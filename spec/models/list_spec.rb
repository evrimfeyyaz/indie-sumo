require 'rails_helper'

describe List do
  it { should belong_to(:resource).touch(true) }
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

  describe '#list_items' do
    subject { create(:list, :with_item) }
    let(:resource) { subject.resource }

    context 'when an item is added' do
      it 'updates the timestamp of the resource' do
        expect do
          subject.list_items << build(:list_item)
        end.to change { resource.reload.updated_at }
      end
    end

    context 'when an item is removed' do
      it 'updates the timestamp of the resource' do
        list_item = subject.list_items.first

        expect do
          subject.list_items.destroy(list_item)
        end.to change { resource.reload.updated_at }
      end
    end
  end
end