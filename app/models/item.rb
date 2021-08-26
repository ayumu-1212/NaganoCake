class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  attachment :image

  with_options presence: true do
    validates :name
    validates :sales_status
    validates :price
  end

  # enum sales_status: { 売切れ: 0, 販売中: 1 }
  enum sales_status: {
    sold_out: 0,
    on_sale: 1
  }

  # 消費税設定
  def add_tax_price
    (self.price * 1.08).round
  end

  # ransack
  scope :sort_by_genre_name_asc, lambda {
    eager_load(:genre)
      .order(Arel.sql('genres.name COLLATE "C" ASC'))
  }

  scope :sort_by_genre_name_desc, lambda {
    eager_load(:genre)
      .order(Arel.sql('genres.name COLLATE "C" DESC'))
  }
end
