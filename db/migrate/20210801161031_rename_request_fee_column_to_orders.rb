class RenameRequestFeeColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :request_fee, :request_total_price
  end
end
