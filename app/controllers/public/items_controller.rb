class Public::ItemsController < ApplicationController
  def index
    if params[:gid].nil?
      @items = Item.all.page(params[:page]).per(12)
    else
      @genre = Genre.find(params[:gid])
      @items = @genre.items.page(params[:page]).per(12)
    end
  end

  def show
    @item = Item.find(params[:id])
    @items = @item.genre.items.shuffle[0..3]
    @cart_item = CartItem.new
  end
end
