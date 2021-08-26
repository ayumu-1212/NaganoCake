class Public::CustomersController < ApplicationController
  before_action :authenticate_end_user!
  def mypage
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      flash[:success] = "会員情報を更新しました"
      redirect_to mypage_customers_path
    else
      render :edit
    end
  end

  def unsubscribe_confirmation
  end

  def unsubscribe_update
    current_end_user.destroy
    flash[:notice] = "退会しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :phone_number)
  end
end
