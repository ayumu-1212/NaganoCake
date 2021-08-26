class Admin::CustomersController < ApplicationController
  def index
    @q = EndUser.with_deleted.ransack(params[:q]) # ransackとparanoia
    @end_users = @q.result.page(params[:page]).per(20) #ransackとkaminari
  end

  def show
    @end_user = EndUser.with_deleted.find(params[:id])
  end

  def edit
    @end_user = EndUser.with_deleted.find(params[:id])
  end

  def update
    @end_user = EndUser.with_deleted.find(params[:id])
    is_deleted = params[:end_user][:is_deleted]
    params[:end_user].delete(:is_deleted)
    if @end_user.update(end_user_params)
      if is_deleted == "退会" && @end_user.deleted_at.nil?
        @end_user.destroy
      elsif is_deleted == "有効" && @end_user.deleted_at.present?
        @end_user.restore
      end
      flash[:success] = "更新が完了しました"
      redirect_to admin_customer_path(@end_user)
    else
      render :edit
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :phone_number, :is_deleted)
  end
end
