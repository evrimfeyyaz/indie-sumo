module Admin
  class CategoriesController < Admin::ApplicationController
    def find_resource(param)
      Category.find_by!(slug: param)
    end

    def delete_icon
      category = requested_resource
      category.icon.purge

      render 'edit', locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource),
      }
    end
  end
end
