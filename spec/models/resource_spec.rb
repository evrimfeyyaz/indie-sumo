require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:resource_associations).dependent(:destroy) }
  it { should have_many(:related_resources).through(:resource_associations) }
  it { should have_many(:related_external_resources).through(:resource_associations) }

  it { should validate_presence_of(:title) }

  describe '#after_save' do
    subject { create(:resource) }

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

    it 'shows resources and external resources that are related to the subject' do
      related_resource          = create(:resource)
      related_external_resource = create(:external_resource)

      subject.related_resources << related_resource
      subject.related_external_resources << related_external_resource

      expect(subject.associated_resources).to include(related_resource)
      expect(subject.associated_resources).to include(related_external_resource)
    end

    it 'shows resources that reference the subject' do
      resource_referencing_subject = create(:resource)

      resource_referencing_subject.related_resources << subject

      expect(subject.associated_resources).to include(resource_referencing_subject)
    end
  end
end
