require 'rails_helper'

describe ExternalResource  do
  it { should have_many(:list_items).dependent(:destroy) }
  it { should validate_presence_of(:title) }

  describe '#after_save' do
    let(:subject) { create(:external_resource) }

    it 'touches all list items referencing it' do
      list_item = create(:list_item, listable: subject)

      expect do
        subject.update(title: 'New Title')
      end.to change { list_item.reload.updated_at }
    end
  end
end
