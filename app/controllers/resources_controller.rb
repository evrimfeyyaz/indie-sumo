class ResourcesController < ApplicationController
  def show
    load_resource
    build_comment
    load_comments
    fresh_when @resource
  end

  private

    def build_comment
      @comment ||= comment_scope.build
    end

    def load_comments
      @comments ||= comment_scope
    end

    def load_resource
      @resource ||= resource_scope
                      .with_attached_icon
                      .includes(:resource_associations)
                      .find_by!(slug: params[:slug])
    end

    def comment_scope
      @resource.comments.where(approved: true)
    end

    def resource_scope
      Resource.all
    end
end