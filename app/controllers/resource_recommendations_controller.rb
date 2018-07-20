class ResourceRecommendationsController < ApplicationController
  def new
    load_category
    build_resource_recommendation
  end

  def create
    load_category
    build_resource_recommendation
    save_resource_recommendation or render 'new'
  end

  private

    def load_category
      @category = category_scope.find(params[:category_id])
    end

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
        redirect_to @category
      end
    end

    def category_scope
      Category.all
    end

    def resource_recommendation_scope
      @category.resource_recommendations
    end
end