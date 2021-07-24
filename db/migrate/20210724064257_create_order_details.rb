class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.string :item_name
      t.integer :tex_excluded_price
      t.integer :amount
      t.integer :production_status
      t.timestamps
    end
  end
end
