class CategoriesController < ApplicationController
  def index
    load_categories
    fresh_when @categories
  end

  def show
    load_category
    coming_soon?
    load_category_resources
    fresh_when @category
  end

  private

    def coming_soon?
      render 'coming_soon' if @category.coming_soon?
    end

    def load_categories
      @categories ||= category_scope.with_attached_icon
    end

    def load_category
      @category ||= category_scope.find_by!(slug: params[:slug])
    end

    def load_category_resources
      @category_resources ||= @category
                                .resources
                                .with_attached_icon
                                .page(params[:page])
    end

    def category_scope
      Category.all
    end
end