require 'rails_helper'

describe 'Categories management' do
  describe 'GET /index' do
    context 'after the first request' do
      it 'responds with 304 (not modified)' do
        get root_url # First request.
        get root_url, params: {}, headers: {
          'HTTP_IF_NONE_MATCH': response.headers['ETag']
        }

        expect(response).to have_http_status(:not_modified)
      end
    end
  end

  describe 'GET /categories/:slug' do
    context 'after the first request' do
      let(:category) { create(:category) }

      before :each do
        get category_url(category)
        @etag = response.headers['ETag']
      end

      it 'responds with 304' do
        get category_url(category), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:not_modified)
      end

      it 'responds with 200 when its resources are updated' do
        create(:resource, categories: [category])

        get category_url(category), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end