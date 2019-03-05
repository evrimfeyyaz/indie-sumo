require 'rails_helper'

describe 'Resources HTTP caching' do
  describe 'GET /:slug' do
    let(:resource) do
      create(:resource, :with_comment)
    end

    before :each do
      get resource_url(resource)
      @etag = response.headers['ETag']
    end

    it 'responds with 200 (ok)' do
      expect(response).to have_http_status(:ok)
    end

    context 'after the first request' do
      it 'responds with 304' do
        get_with_etag(resource_url(resource), @etag)

        expect(response).to have_http_status(:not_modified)
      end

      it 'responds with 200 when its categories are updated' do
        create(:category, resources: [resource])

        get_with_etag(resource_url(resource), @etag)

        expect(response).to have_http_status(:ok)
      end

      it 'responds with 200 when a comment is added' do
        create(:comment, resource: resource)

        get_with_etag(resource_url(resource), @etag)

        expect(response).to have_http_status(:ok)
      end

      it 'responds with 200 when a comment is updated' do
        comment = resource.comments.first
        comment.update(name: 'New Name')

        get_with_etag(resource_url(resource), @etag)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end