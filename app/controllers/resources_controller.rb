class ResourcesController < ApplicationController
  def show
    load_resource
    build_comment
  end

  private

    def build_comment
      @comment ||= @resource.comments.build
    end

    def load_resource
      @resource ||= resource_scope.find_by!(slug: params[:slug])
    end

    def resource_scope
      Resource.all
    end
end