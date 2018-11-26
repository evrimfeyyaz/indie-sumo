class SearchesController < ApplicationController
  def show
    build_search_results
  end

  private

    def build_search_results
      @search_results ||= Resource.search(params[:query]).page(params[:page])
    end
end