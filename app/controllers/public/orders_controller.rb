class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @orders = current_end_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @order = Order.new
  end

  def order_valid
    delivery_destination_item = params[:order][:delivery_destination_item]
    delivery_destination_id = params[:order][:delivery_destination_id]
    @order = Order.new
    @cart_items = current_end_user.cart_items
    @error_messages = []
    # どの配送先入力を選んだか
    case delivery_destination_item
    when "my_address" then
      # 自分の住所選択
      params[:order][:postal_code] = current_end_user.postal_code
      params[:order][:address] = current_end_user.address
      params[:order][:label_name] = current_end_user.last_name + current_end_user.first_name
      render :order_valid
    when "registered_address" then
      # 過去の住所から選択
      if delivery_destination_id == "nothing"
        # 登録されている住所がない場合
        @error_messages.push("登録されている住所がありません")
        render :new
      elsif delivery_destination_id == "noselect"
        # 選択されている住所がない場合
        @error_messages.push("住所が選択されていません")
        render :new
      else
        delivery_destination = DeliveryDestination.find(delivery_destination_id)
        params[:order][:postal_code] = delivery_destination.postal_code
        params[:order][:address] = delivery_destination.address
        params[:order][:label_name] = delivery_destination.label_name
        render :order_valid
      end
    when "new_address" then
      # 住所登録フォームを入力
      if params[:order][:postal_code].blank? || params[:order][:address].blank? || params[:order][:label_name].blank?
        # 入力に不備があった場合
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.label_name = params[:order][:label_name]
        @error_messages.push("郵便番号を入力していません。") if @order.postal_code.blank?
        @error_messages.push("住所を入力していません。") if @order.address.blank?
        @error_messages.push("宛名を入力していません。") if @order.label_name.blank?
        render :order_valid
      else
        render :order_valid
      end
    else
    end
  end

  def confirm
  end

  def back
    @order = Order.new
    if params[:order][:delivery_destination_item] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.label_name = params[:order][:label_name]
    else
      params[:order][:postal_code] = ""
      params[:order][:address] = ""
      params[:order][:label_name] = ""
    end
    render :new
  end

  def create
    delivery_destination_item = params[:order][:delivery_destination_item]
    params[:order].delete(:delivery_destination_item)
    order = Order.new(order_params)
    order.end_user_id = current_end_user.id
    order.status = 0
    if order.save
      if delivery_destination_item == "new_address"
        DeliveryDestination.create(
          end_user_id: current_end_user.id,
          postal_code: order.postal_code,
          address: order.address,
          label_name: order.label_name
        )
      end
      current_end_user.cart_items.each do |cart_item|
        OrderDetail.create(
          order_id: order.id,
          item_id: cart_item.item_id,
          including_tax_purchase_price: cart_item.item.add_tax_price,
          amount: cart_item.amount,
          production_status: 1
        )
      end
      current_end_user.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :order_valid
    end
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:label_name, :postal_code, :address, :payment_method, :status, :shipping_fee, :request_total_price, :delivery_destination_item, :delivery_destination_id)
  end

end
