require 'rails_helper'
require 'shared_examples/shared_examples_for_sluggables'

describe Resource do
  it_behaves_like 'a sluggable'

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:list_items).through(:lists) }
  it { should have_many(:information_recommendations).dependent(:destroy) }
  it { should have_many(:creators).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe '#after_save' do
    subject { create(:resource) }

    it 'updates the timestamp on creator objects that reference it' do
      creator = create(:creator, referenced_resource: subject)

      expect do
        subject.update(title: 'New Title')
      end.to change { creator.reload.updated_at }
    end

    it 'updates the timestamp on list items that reference it' do
      list_item = create(:list_item, listable: subject)

      expect do
        subject.update(title: 'New Title')
      end.to change { list_item.reload.updated_at }
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
