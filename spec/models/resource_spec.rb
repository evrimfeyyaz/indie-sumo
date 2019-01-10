require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:list_items).through(:lists) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe '#after_save' do
    subject { create(:resource) }

    it 'updates the timestamp on resources that reference it as a list item' do
      resource  = create(:resource, :with_list)
      list_item = resource.lists.first.list_items.first
      list_item.update(listable: subject)

      expect do
        subject.update(title: 'New Title')
      end.to change { resource.reload.updated_at }
    end

    it 'touches all its categories' do
      category = create(:category, resources: [subject])

      expect do
        subject.update(title: 'New Title')
      end.to change { category.reload.updated_at }
    end
  end

  describe '#categories' do
    subject { create(:resource, :with_category) }

    context 'when a category is added' do
      it 'updates the timestamp' do
        expect do
          subject.categories << build(:category)
        end.to change { subject.reload.updated_at }
      end
    end

    context 'when a category is removed' do
      it 'updates the timestamp' do
        category = subject.categories.first

        expect do
          subject.categories.destroy(category)
        end.to change { subject.reload.updated_at }
      end
    end
  end
end
