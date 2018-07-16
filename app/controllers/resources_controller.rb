class ResourcesController < ApplicationController
  def show
    load_resource
  end

  private

    def load_resource
      @resource ||= resource_scope.find(params[:id])
    end

    def resource_scope
      Resource.all
    end
end