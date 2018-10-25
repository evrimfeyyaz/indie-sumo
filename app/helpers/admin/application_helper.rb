module Admin
  module ApplicationHelper
    def navigation_link_title(resource_name)
      suffix = ''

      if resource_name.resource == 'comments' &&
        unapproved_comments_count > 0

        suffix = " (#{unapproved_comments_count})"
      elsif resource_name.resource == 'resource_recommendations' &&
        resource_recommendations_count > 0

        suffix = " (#{resource_recommendations_count})"
      elsif resource_name.resource == 'information_recommendations' &&
        information_recommendations_count > 0

        suffix = " (#{information_recommendations_count})"
      end

      display_resource_name(resource_name) + suffix
    end

    def unapproved_comments_count
      Comment.where(approved: false).count
    end

    def resource_recommendations_count
      ResourceRecommendation.count
    end

    def information_recommendations_count
      InformationRecommendation.count
    end
  end
end
