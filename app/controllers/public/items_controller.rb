class Public::ItemsController < ApplicationController
  def index
    if params[:gid].nil?
      @items = Item.all
    else
      @genre = Genre.find(params[:gid])
      @items = @genre.items
    end
  end
end
