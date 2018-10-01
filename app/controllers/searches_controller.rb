class SearchesController < ApplicationController
  def show
    build_search_results
  end

  private

    def build_search_results
      @search_results ||= Resource.search(params[:query],
                                          highlight: { tag: '<mark>' },
                                          load:      false,
                                          fields:    [{ 'title^5': :word_start },
                                                      { search_description: :word_middle }])
    end
end