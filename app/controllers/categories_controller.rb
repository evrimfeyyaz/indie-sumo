class CategoriesController < ApplicationController
  def index
    load_categories
  end

  def show
    load_category
  end

  private

    def load_categories
      @categories ||= category_scope
    end

    def load_category
      @category ||= category_scope.find_by!(slug: params[:slug])
    end

    def category_scope
      Category.all
    end
end