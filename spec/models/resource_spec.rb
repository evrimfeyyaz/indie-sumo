require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should belong_to(:category).touch(true).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:resource_associations).dependent(:destroy) }
  it { should have_many(:related_resources).through(:resource_associations) }
  it { should have_many(:related_external_resources).through(:resource_associations) }

  it { should validate_presence_of(:title) }

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
