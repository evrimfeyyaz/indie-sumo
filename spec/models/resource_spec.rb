require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:list_items).through(:lists) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:resource_associations) }
  it { should have_many(:referenced_resources).through(:resource_associations) }
  it { should have_many(:referenced_external_resources).through(:resource_associations) }

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

  describe '#associated_resources' do
    subject { create(:resource) }

    it 'shows resources and external resources that the subject is referencing' do
      referenced_resource          = create(:resource)
      referenced_external_resource = create(:external_resource)

      subject.referenced_resources << referenced_resource
      subject.referenced_external_resources << referenced_external_resource

      expect(subject.associated_resources).to include(referenced_resource)
      expect(subject.associated_resources).to include(referenced_external_resource)
    end

    it 'shows resources that reference the subject' do
      resource_referencing_subject = create(:resource)

      resource_referencing_subject.referenced_resources << subject

      expect(subject.associated_resources).to include(resource_referencing_subject)
    end
  end
end
