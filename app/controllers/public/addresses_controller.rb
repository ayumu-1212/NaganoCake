class Public::AddressesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :identity_verification, only: [:edit, :update, :destroy]
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
      @delivery_destinations = current_end_user.delivery_destinations
      if @delivery_destination.errors.messages[:postal_code][0] == "は数値で入力してください"
        flash[:danger] = "郵便番号はハイフンなしの半角数字のみで記述してください"
      end
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
      if @delivery_destination.errors.messages[:postal_code][0] == "は数値で入力してください"
        flash[:danger] = "郵便番号はハイフンなしの半角数字のみで記述してください"
      end
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
  def identity_verification
    delivery_destination = DeliveryDestination.find(params[:id])
    if delivery_destination.end_user_id != current_end_user.id
      flash[:danger] = "アクセスできません"
      redirect_to mypage_customers_path
    end
  end

  def delivery_destination_params
    params.require(:delivery_destination).permit(:postal_code, :address, :label_name, :end_user_id)
  end
end
