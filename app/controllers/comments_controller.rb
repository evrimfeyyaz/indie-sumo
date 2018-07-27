class CommentsController < ApplicationController
  def create
    load_resource
    build_comment
    save_comment or render @resource
  end

  private

    def load_resource
      @resource = resource_scope.find_by!(slug: params[:resource_slug])
    end

    def build_comment
      @comment            ||= comment_scope.build
      @comment.attributes = comment_params
    end

    def comment_params
      comment_params = params[:comment]
      comment_params ? comment_params.permit(:name, :email, :comment) : {}
    end

    def save_comment
      if verify_recaptcha(model: @comment) && @comment.save
        flash[:success] = 'Thanks for your comment!'
        redirect_to @resource
      end
    end

    def resource_scope
      Resource.all
    end

    def comment_scope
      @resource.comments
    end
end