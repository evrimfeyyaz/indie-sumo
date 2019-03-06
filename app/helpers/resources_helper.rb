module ResourcesHelper
  def resource_image(resource)
    if resource.icon.attached?
      polymorphic_url(resource.icon)
    else
      APP_SETTINGS['social_share_image']
    end
  end
end