class Public::HomesController < ApplicationController
  layout "top_base", only: [:top]
  def top
    @items = Item.all.shuffle[0..7]
  end

  def about

  end
end
