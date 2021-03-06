module Admin
  class CategoriesController < Admin::ApplicationController
    def find_resource(param)
      Category.find_by!(slug: param)
    end

    def delete_icon
      category = requested_resource
      category.icon.purge

      redirect_to edit_admin_category_url(category)
    end
  end
end
