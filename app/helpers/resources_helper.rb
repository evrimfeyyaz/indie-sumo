module ResourcesHelper
  def category_links(resource)
    links = resource.categories.map do |category|
      link_to category.title, category, class: 'link'
    end

    links.join(' | ').html_safe
  end
end