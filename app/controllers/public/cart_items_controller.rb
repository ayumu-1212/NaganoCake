class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :identity_verification, only: [:update, :destroy]
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
    if @cart_item = CartItem.find_by(end_user_id: current_end_user.id, item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.end_user_id = current_end_user.id
    end

    if @cart_item.save
      flash[:info] = "カートに追加しました"
      redirect_to cart_items_path
    else
      render "items/show"
    end
  end

  private
  def identity_verification
    cart_item = CartItem.find(params[:id])
    if cart_item.end_user_id != current_end_user.id
      flash[:danger] = "アクセスできません"
      redirect_to mypage_customers_path
    end
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount, :end_user_id, :item_id)
  end
end
