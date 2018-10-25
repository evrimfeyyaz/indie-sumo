module Admin
  class ResourcesController < Admin::ApplicationController
    def find_resource(param)
      Resource.find_by!(slug: param)
    end
  end
end
