class ResourceRecommendationsController < ApplicationController
  def new
    build_resource_recommendation
  end

  def create
    build_resource_recommendation
    save_resource_recommendation or render 'new'
  end

  private

    def build_resource_recommendation
      @resource_recommendation            ||= resource_recommendation_scope.build
      @resource_recommendation.attributes = resource_recommendation_params
    end

    def resource_recommendation_params
      resource_recommendation_params = params[:resource_recommendation]
      resource_recommendation_params ? resource_recommendation_params.permit(:recommender_name,
                                                                             :recommender_email,
                                                                             :name,
                                                                             :website,
                                                                             :other_information) : {}
    end

    def save_resource_recommendation
      if @resource_recommendation.save
        flash[:success] = 'Thank you for your recommendation!'
        redirect_back(fallback_location: root_path)
      end
    end

    def resource_recommendation_scope
      ResourceRecommendation.all
    end
end