require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:information_recommendations).dependent(:destroy) }
  it { should have_many(:creators).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe '#after_save' do
    let(:subject) { create(:resource) }

    it 'touches all categories it belongs to' do
      category = create(:category, resources: [subject])

      subject.reload

      expect do
        subject.update(title: 'New Title')
      end.to change { category.reload.updated_at }
    end
  end

  describe '#categories' do
    let(:subject) { create(:resource) }

    it 'touches updated at when a category is added' do
      category = create(:category, resources: [subject])

      expect do
        subject.categories << category
      end.to change { subject.reload.updated_at }
    end

    it 'touches updated at when a category is removed' do
      category = create(:category, resources: [subject])
      subject.categories << category

      expect do
        subject.categories.delete(category)
      end.to change { subject.reload.updated_at }
    end
  end

  describe '#lists' do
    let(:subject) { create(:resource) }

    it 'touches updated at when a list is added' do
      list = create(:list, resource: subject)

      expect do
        subject.lists << list
      end.to change { subject.reload.updated_at }
    end

    it 'touches updated at when a list is removed' do
      list = create(:list, resource: subject)
      subject.lists << list

      expect do
        subject.lists.delete(list)
      end.to change { subject.reload.updated_at }
    end
  end

  describe '#creators' do
    let(:subject) { create(:resource) }

    it 'touches updated at when a creator is added' do
      creator = create(:creator, resource: subject)

      expect do
        subject.creators << creator
      end.to change { subject.reload.updated_at }
    end

    it 'touches updated at when a creator is removed' do
      creator = create(:creator, resource: subject)
      subject.creators << creator

      expect do
        subject.creators.delete(creator)
      end.to change { subject.reload.updated_at }
    end
  end

  describe '#comments' do
    let(:subject) { create(:resource) }

    it 'touches updated at when a comment is added' do
      comment = create(:comment, resource: subject)

      expect do
        subject.comments << comment
      end.to change { subject.reload.updated_at }
    end

    it 'touches updated at when a comment is removed' do
      comment = create(:comment, resource: subject)
      subject.comments << comment

      expect do
        subject.comments.delete(comment)
      end.to change { subject.reload.updated_at }
    end
  end

  describe '#links_as_string' do
    before(:each) do
      subject.website = 'https://www.example.com'
      subject.twitter = 'https://www.twitter.com'
      subject.github  = 'https://www.github.com'
      subject.youtube = 'https://www.youtube.com'
    end

    it 'returns all links as a string' do
      %w{website twitter github youtube}.each do |link|
        expect(subject.links_as_string).to include(subject[link])
      end
    end

    it 'does not return missing links in the string' do
      subject.twitter = nil

      expect(subject.links_as_string).not_to include('Twitter')
    end
  end

  describe '#categories_as_string' do
    it 'returns all category title' do
      category1 = build(:category)
      category2 = build(:category)

      subject.categories = [category1, category2]

      expect(subject.categories_as_string).to include(category1.title)
      expect(subject.categories_as_string).to include(category2.title)
    end
  end
end
