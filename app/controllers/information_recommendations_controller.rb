class InformationRecommendationsController < ApplicationController
  def new
    load_resource
    build_information_recommendation
  end

  def create
    load_resource
    build_information_recommendation
    save_information_recommendation or respond_to do |format|
      format.js
    end
  end

  private

    def load_resource
      @resource = resource_scope.find_by!(slug: params[:resource_slug])
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
      if verify_recaptcha(model: @information_recommendation) && @information_recommendation.save
        flash[:success] = 'We will consider your addition, thanks!'
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