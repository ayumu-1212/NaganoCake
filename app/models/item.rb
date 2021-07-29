class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items

  attachment :image

  with_options presence: true do
    validates :name
    validates :sales_status
    validates :tax_excluded_price
  end

  enum sales_status: { 売切れ: 0, 販売中: 1 }
end
