class Order < ApplicationRecord
  has_many :order_details
  belongs_to :end_user

  with_options presence: true do
    validates :address_label
    validates :postal_code
    validates :delivery_address
    validates :payment_method
    validates :status
    validates :shipping_fee
    validates :tax_rate
  end

  enum payment_method: { クレジットカード: 1, 銀行振込: 2 }
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }
end
