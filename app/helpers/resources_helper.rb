module ResourcesHelper
  def category_links(resource)
    links = resource.categories.map do |category|
      link_to category.title, category, class: 'link'
    end

    links.join(' | ').html_safe
  end

  def creator_links(resource)
    links = resource.creators.sort_by { |c| c.name }.map do |creator|
      link_to_if creator.url.present?, creator.name, creator.url, class: 'link'
    end

    links.join(', ').html_safe
  end
end