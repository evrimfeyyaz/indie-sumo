require 'rails_helper'

describe ExternalResource  do
  it { should have_many(:list_items).dependent(:destroy) }
  it { should validate_presence_of(:title) }

  describe '#after_save' do
    subject { create(:external_resource) }

    it 'updates the timestamp on resources that reference it as a list item' do
      resource = create(:resource, :with_list)
      list_item = resource.lists.first.list_items.first
      list_item.update(listable: subject)

      expect do
        subject.update(title: 'New Title')
      end.to change { resource.reload.updated_at }
    end
  end
end
