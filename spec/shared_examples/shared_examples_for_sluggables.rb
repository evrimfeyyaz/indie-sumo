TITLE = 'Test Title'.freeze

shared_examples_for 'a sluggable' do
  let(:sluggable) { described_class.new(title: TITLE) }
  let(:class_name_as_parameter) { described_class.model_name.param_key }

  describe '#get_slug' do
    it 'returns a parameterized slug' do
      expect(sluggable.get_slug).to eq('test-title')
    end

    context 'when another object with the same slug exists' do
      it 'adds a trailing number to the slug' do
        # Create a new object of the described class through
        # Factory Bot. I know, it's a bit hacky.
        create(class_name_as_parameter, slug: 'test-title')

        expect(sluggable.get_slug).to eq('test-title-1')
      end
    end
  end

  describe '#to_param' do
    it 'returns the slug' do
      expect(sluggable.to_param).to eq(sluggable.slug)
    end
  end

  describe 'before creation' do
    context 'when a slug exists' do
      it 'does nothing' do
        slug = 'NOT-IMPORTANT'
        title = 'SOMETHING-ELSE-NOT-IMPORTANT'

        object = create(class_name_as_parameter, title: title, slug: slug)

        expect(object.slug).to eq(slug)
      end
    end

    context 'when no slug is given' do
      it 'creates a slug from the title' do
        object = create(class_name_as_parameter, title: 'Some Title')

        expect(object.slug).to eq('some-title')
      end
    end
  end
end