class InformationRecommendationsController < ApplicationController
  def new
    load_resource
    build_information_recommendation
  end

  def create
    load_resource
    build_information_recommendation
    save_information_recommendation or render 'new'
  end

  private

    def load_resource
      @resource = resource_scope.find(params[:resource_id])
    end

    def build_information_recommendation
      @information_recommendation            ||= information_recommendation_scope.build
      @information_recommendation.attributes = information_recommendation_params
    end

    def information_recommendation_params
      information_recommendation_params = params[:information_recommendation]
      information_recommendation_params ? information_recommendation_params.permit(:recommender_name,
                                                                                   :recommender_email,
                                                                                   :information) : {}
    end

    def save_information_recommendation
      if @information_recommendation.save
        flash[:success] = 'Thank you for your addition!'
        redirect_to @resource
      end
    end

    def information_recommendation_scope
      @resource.information_recommendations
    end

    def resource_scope
      Resource.all
    end
end