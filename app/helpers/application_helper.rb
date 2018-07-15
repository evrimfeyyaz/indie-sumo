module ApplicationHelper
  def add_link_title_for(category_obj)
    "Add #{category_obj.class.name}"
  end
end
