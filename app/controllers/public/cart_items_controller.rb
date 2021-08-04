class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @cart_items = current_end_user.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = "個数を変更しました"
      redirect_to cart_items_path
    else
      @cart_items = current_end_user.cart_items
      flash[:alert] = "もう一度更新してください"
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_end_user.cart_items
    @cart_items.destroy_all
    flash[:success] = "すべて削除しました"
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
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
