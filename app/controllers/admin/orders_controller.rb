class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:end_user_id].nil?
      @orders = Order.all.page(params[:page]).per(20)
    else
      end_user = EndUser.find(params[:end_user_id])
      @orders = Order.where(end_user_id: end_user.id).page(params[:page]).per(20)
      flash.now[:info] = "こちらは#{end_user.last_name + end_user.first_name}さんの注文履歴です。"
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "注文ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = "更新に失敗しました。再度更新してください。"
      @order_details = @order.order_details
      render :show
    end
  end

  def update_items
    order_detail = OrderDetail.find(params[:id])
    @order = order_detail.order
    if order_detail.update(order_detail_params)
      if order_detail.in_production?
        @order.update(status: 2)
      elsif @order.order_details.pluck(:production_status).all? {|i| ["start_not_possible", "production_complete"].include?(i)}
        @order.update(status: 3)
      end
      flash[:success] = "製作ステータスを更新しました"
      redirect_to admin_order_path(order_detail.order)
    else
      flash[:danger] = "更新に失敗しました。再度更新してください。"
      @order_details = @order.order_details
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
