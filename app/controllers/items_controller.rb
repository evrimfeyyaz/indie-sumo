class ItemsController < ApplicationController
  def show
    load_item
  end

  private

    def load_item
      @item ||= item_scope.find(params[:id])
    end

    def item_scope
      Item.all
    end
end