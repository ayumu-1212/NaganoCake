class Address < ApplicationRecord
    belongs_to :end_user
    with_options presence: true do
      validates :postal_code
      validates :delivery_address
      validates :name
    end
end
