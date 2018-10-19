require 'rails_helper'

describe 'Resources management' do
  describe 'GET /:slug' do
    context 'after the first request' do
      let(:resource) { create(:resource) }

      before :each do
        get resource_url(resource)
        @etag = response.headers['ETag']
      end

      it 'responds with 304' do
        get resource_url(resource), params: {}, headers: {
          'HTTP_IF_NONE_MATCH': @etag
        }

        expect(response).to have_http_status(:not_modified)
      end

      # it 'responds with 200 when its resources are updated' do
      #   create(:resource, categories: [resource])
      #
      #   get resource_url(resource), params: {}, headers: {
      #     'HTTP_IF_NONE_MATCH': @etag
      #   }
      #
      #   expect(response.code).to eq('200')
      # end
    end
  end
end