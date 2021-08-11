class Public::ItemsController < ApplicationController
  def index
    @q = Item.ransack(params[:q]) # ransack
    @items = @q.result.page(params[:page]).per(20) #ransackとkaminari
  end

  def show
    @item = Item.find(params[:id])
    @items = @item.genre.items.shuffle[0..3]
    @cart_item = CartItem.new
  end
end
