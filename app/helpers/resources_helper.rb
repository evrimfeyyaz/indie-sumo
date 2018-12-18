module ResourcesHelper
  def category_links(resource)
    links = resource.categories.map do |category|
      link_to category.title, category, class: 'link'
    end

    links.join(' | ').html_safe
  end

  def resource_image(resource)
    if resource.icon.attached?
      polymorphic_url(resource.icon)
    else
      APP_SETTINGS['social_share_image']
    end
  end
end