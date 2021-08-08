class DeliveryDestination < ApplicationRecord
    belongs_to :end_user
    with_options presence: true do
      validates :postal_code
      validates :address
      validates :label_name
    end
end
