module HttpCachingHelpers
  def get_with_etag(path, etag)
    get path, params: {}, headers: {
      'HTTP_IF_NONE_MATCH': etag
    }
  end
end

RSpec.configure do |c|
  c.include HttpCachingHelpers
end