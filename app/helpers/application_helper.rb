module ApplicationHelper
  def add_link_title_for(category)
    "Add #{category.title.singularize}"
  end
end
