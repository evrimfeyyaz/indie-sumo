class CategoriesController < ApplicationController
  def index
    load_categories
    fresh_when @categories
  end

  def show
    load_category
    load_category_resources
    fresh_when @category
  end

  private

    def load_categories
      @categories ||= category_scope
    end

    def load_category
      @category ||= category_scope.find_by!(slug: params[:slug])
    end

    def load_category_resources
      @category_resources ||= @category.resources.page(params[:page])
    end

    def category_scope
      Category.all
    end
end