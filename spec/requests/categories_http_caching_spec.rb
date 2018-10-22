require 'rails_helper'

describe 'Categories HTTP caching' do
  describe 'GET /index' do
    before :each do
      get root_url # First request.
      @etag = response.headers['ETag']
    end

    it 'responds with 200 (ok)' do
      expect(response).to have_http_status(:ok)
    end

    context 'after the first request' do
      it 'responds with 304 (not modified)' do
        get root_url, params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:not_modified)
      end
    end
  end

  describe 'GET /categories/:slug' do
    let(:category) { create(:category, :with_resource) }

    before :each do
      get category_url(category)
      @etag = response.headers['ETag']
    end

    it 'responds with 200 (ok)' do
      expect(response).to have_http_status(:ok)
    end

    context 'after the first request' do
      it 'responds with 304' do
        get category_url(category), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:not_modified)
      end

      it 'responds with 200 when a resource is added' do
        create(:resource, categories: [category])

        get category_url(category), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:ok)
      end

      it 'responds with 200 when a resource is updated' do
        create(:resource, categories: [category])

        get category_url(category), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end