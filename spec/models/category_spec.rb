require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Category do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:resources) }
  it { should have_many(:resource_recommendations).dependent(:destroy) }
  it { should validate_presence_of(:title) }

  describe '#after_save' do
    let(:subject) { create(:category) }

    it 'touches all resources it has' do
      resource = create(:resource, categories: [subject])

      subject.reload

      expect do
        subject.update(title: 'New Title')
      end.to change { resource.reload.updated_at }
    end
  end

  describe '#resources' do
    let(:subject) { create(:category) }

    it 'touches updated at when a resource is added' do
      resource = create(:resource, categories: [subject])

      expect do
        subject.resources << resource
      end.to change { subject.reload.updated_at }
    end

    it 'touches updated at when a resource is removed' do
      resource = create(:resource, categories: [subject])
      subject.resources << resource

      expect do
        subject.resources.delete(resource)
      end.to change { subject.reload.updated_at }
    end
  end
end
