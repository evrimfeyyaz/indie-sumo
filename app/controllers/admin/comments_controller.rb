module Admin
  class CommentsController < Admin::ApplicationController
    def toggle_approval
      requested_resource.toggle!(:approved)
      redirect_to admin_comments_url
    end
  end
end
