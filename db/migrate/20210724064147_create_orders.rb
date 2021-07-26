class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id
      t.string :label_name
      t.string :postal_code
      t.string :address
      t.integer :payment_method
      t.integer :status
      t.integer :shipping_fee
      t.integer :request_fee
      t.timestamps
    end
  end
end
