module ResourceHelper
  # Extracts the URL to follow from Resources and External Resources.
  def resource_url(item)
    case item
    when Resource
      item
    when ExternalResource
      item.url
    else
      nil
    end
  end
end