require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Category do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:resources) }
  it { should validate_presence_of(:title) }

  describe '#after_save' do
    subject { create(:category) }

    it 'touches all its resources' do
      resource = create(:resource, categories: [subject])

      expect do
        subject.update(title: 'New Title')
      end.to change { resource.reload.updated_at }
    end
  end

  describe '#resources' do
    subject { create(:category, :with_resource) }

    context 'when a resource is added' do
      it 'updates the timestamp' do
        expect do
          subject.resources << build(:resource)
        end.to change { subject.reload.updated_at }
      end
    end

    context 'when a category is removed' do
      it 'updates the timestamp' do
        resource = subject.reload.resources.first

        expect do
          subject.resources.destroy(resource)
        end.to change { subject.reload.updated_at }
      end
    end
  end
end
