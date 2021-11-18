class Order < ApplicationRecord
   belongs_to :customer
   has_many :order_details, dependent: :destroy

   enum status: {
      wating_for_payment: 0,
      confirmed_payment: 1,
      making: 2,
      ready_to_ship: 3,
      sent: 4
   }

   enum payment_method: {
      credit_card: 0,
      transfer: 1
   }
 
end
