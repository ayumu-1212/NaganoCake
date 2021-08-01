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
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "更新が完了しました"
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :sales_status, :genre_id)
  end
end