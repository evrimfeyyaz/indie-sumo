class CommentsController < ApplicationController
  def create
    load_resource
    build_comment
    load_comments
    save_comment or respond_to do |format|
      format.js
    end
  end

  private

    def load_resource
      @resource ||= resource_scope.find_by!(slug: params[:resource_slug])
    end

    def build_comment
      @comment            ||= comment_scope.build
      @comment.attributes = comment_params
      @comment.approved   = false
    end

    def load_comments
      @comments ||= comment_scope
    end

    def comment_params
      comment_params = params[:comment]
      comment_params ? comment_params.permit(:name, :email, :comment) : {}
    end

    def save_comment
      if verify_recaptcha(model: @comment) && @comment.save
        flash[:success] = 'Thanks for your comment! We will publish it after reviewing it.'
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