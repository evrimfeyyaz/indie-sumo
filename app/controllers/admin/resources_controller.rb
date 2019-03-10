module Admin
  class ResourcesController < Admin::ApplicationController
    def find_resource(param)
      Resource.find_by!(slug: param)
    end

    def delete_icon
      resource = requested_resource
      resource.icon.purge

      redirect_to edit_admin_resource_url(resource)
    end
  end
end
