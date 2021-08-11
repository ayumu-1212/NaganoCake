class Order < ApplicationRecord
  has_many :order_details
  belongs_to :end_user

  with_options presence: true do
    validates :label_name
    validates :postal_code
    validates :address
    validates :payment_method
    validates :status
    validates :shipping_fee
    validates :request_total_price
  end

  # enum payment_method: { クレジットカード: 1, 銀行振込: 2 }
  enum payment_method: {
    credit_card: 1,
    bank_transfer: 2
  }
  # enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }
  enum status: {
    payment_waiting: 0,
    payment_confirmation: 1,
    in_production: 2,
    preparing_delivery: 3,
    delivered: 4
  }

  # ransack
  scope :sort_by_end_user_last_name_asc, lambda {
    eager_load(:end_user)
      .order(Arel.sql('end_users.last_name COLLATE "C" ASC'))
  }

  scope :sort_by_end_user_last_name_desc, lambda {
    eager_load(:end_user)
      .order(Arel.sql('end_users.last_name COLLATE "C" DESC'))
  }
end
