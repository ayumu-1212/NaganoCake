class OrderDetail < ApplicationRecord
  belongs_to :order_details
  with_options presence: true do
    validates :item_name
    validates :including_tax_purchase_price
    validates :amount
    validates :production_status
  end

  enum production_status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }
end
