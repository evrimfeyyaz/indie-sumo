module Admin
  module ApplicationHelper
    def navigation_link_title(resource_name)
      suffix = ''

      if resource_name.resource == 'comments' &&
        unapproved_comments_count > 0

        suffix = " (#{unapproved_comments_count})"
      end

      display_resource_name(resource_name) + suffix
    end

    def unapproved_comments_count
      Comment.where(approved: false).count
    end
  end
end
