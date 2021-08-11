class DeliveryDestination < ApplicationRecord
    belongs_to :end_user
    with_options presence: true do
      validates :postal_code, numericality: true
      validates :address
      validates :label_name
    end
end
