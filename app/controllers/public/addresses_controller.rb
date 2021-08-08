class Public::AddressesController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @delivery_destination = DeliveryDestination.new
    @delivery_destinations = current_end_user.delivery_destinations
  end

  def create
    @delivery_destination = DeliveryDestination.new(delivery_destination_params)
    @delivery_destination.end_user_id = current_end_user.id
    if @delivery_destination.save
      flash[:success] = "配送先を登録しました"
      redirect_to addresses_path
    else
      @delivery_destinations = current_end_user.delivery_destination
      render :index
    end
  end

  def edit
    @delivery_destination = DeliveryDestination.find(params[:id])
  end

  def update
    @delivery_destination = DeliveryDestination.find(params[:id])
    if @delivery_destination.update(delivery_destination_params)
      flash[:success] = "配送先を更新しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @delivery_destination = DeliveryDestination.find(params[:id])
    @delivery_destination.destroy
    flash[:success] = "配送先を一件削除しました"
    redirect_to addresses_path
  end

  private
  def delivery_destination_params
    params.require(:delivery_destination).permit(:postal_code, :address, :label_name, :end_user_id)
  end
end
