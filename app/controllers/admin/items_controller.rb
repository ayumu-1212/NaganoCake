class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "商品を登録しました"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def show
  end

  def update
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :tax_excluded_price, :image, :sales_status, :genre_id)
  end
end