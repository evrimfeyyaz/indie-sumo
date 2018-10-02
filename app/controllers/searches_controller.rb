class SearchesController < ApplicationController
  def show
    build_search_results
  end

  private

    def build_search_results
      @search_results ||= Resource.search(params[:query],
                                          highlight: { tag: '<mark>' },
                                          load:      true,
                                          fields:    [{ 'title^5': :word_start },
                                                      { 'description^4': :word_start },
                                                      { 'links^3': :word_middle },
                                                      { 'categories^2': :word_start }])
    end
end