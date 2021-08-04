class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!
end
