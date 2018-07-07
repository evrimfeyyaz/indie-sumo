class CategoriesController < ApplicationController
  def index
    load_categories
  end

  private

  def load_categories
    @categories ||= category_scope
  end

  def category_scope
    Category.all
  end
end