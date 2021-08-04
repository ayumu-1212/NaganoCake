class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.with_deleted.all
  end
end
