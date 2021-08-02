class Public::CartItemsController < ApplicationController
  def index
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      flash[:info] = "カートに追加しました"
      redirect_to cart_items_path
    else
      render "items/show"
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :end_user_id, :item_id)
  end
end
