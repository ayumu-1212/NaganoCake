class CartItem < ApplicationRecord
    belongs_to :end_user
    belongs_to :item
    validates :amount, presence: true
end
