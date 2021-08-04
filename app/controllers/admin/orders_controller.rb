class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:end_user_id].nil?
      @orders = Order.all
    else
      end_user = EndUser.find(params[:end_user_id])
      @orders = Order.where(end_user_id: end_user.id)
      flash[:info] = "こちらは#{end_user.last_name + end_user.first_name}さんの注文履歴です。"
    end
  end
end
