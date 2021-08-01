class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items

  attachment :image

  with_options presence: true do
    validates :name
    validates :sales_status
    validates :price
  end

  enum sales_status: { 売切れ: 0, 販売中: 1 }

  # 消費税設定
  def add_tax_price
    (self.price * 1.08).round
  end
end
