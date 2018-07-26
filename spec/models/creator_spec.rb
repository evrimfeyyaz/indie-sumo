require 'rails_helper'

describe Creator do
  it { should belong_to(:resource) }
  it { should belong_to(:referenced_resource).optional }

  it 'has a name when it does not have a reference to a resource' do
    should validate_presence_of(:name)
  end

  it 'is valid with a resource reference and no name' do
    referenced_resource = create(:resource)

    subject.referenced_resource = referenced_resource
    subject.validate

    expect(subject.errors[:name]).not_to include("can't be blank")
  end

  describe '#name' do
    it 'returns the name of the referenced resource when it is present' do
      referenced_resource = create(:resource)

      subject.referenced_resource = referenced_resource

      expect(subject.name).to eq(referenced_resource.title)
    end

    it 'returns the name when no resource is referenced' do
      name = 'Test Name'

      subject.name = name

      expect(subject.name).to eq(name)
    end
  end

  describe '#url' do
    it 'returns the path of the referenced resource when it is present' do
      referenced_resource = create(:resource)

      subject.referenced_resource = referenced_resource

      expect(subject.url).to eq(Rails.application.routes.url_helpers.resource_path(referenced_resource))
    end

    it 'returns the URL when no resource is referenced' do
      url = 'http://www.example.com'

      subject.url = url

      expect(subject.url).to eq(url)
    end
  end
end