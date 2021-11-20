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
   
   
  def set_receiver(receiver)
    self.address = receiver.address
    self.postal_code = receiver.postal_code
    if receiver.is_a?(Customer)
      self.name = receiver.full_name.gsub(" ", "")
    else
      self.name = receiver.name
    end
  end

  def order_products_total_price
    (self.total_price - self.postage).round
  end

  def order_products_total_quantity
    self.order_products.sum(:quantity)
  end

  private

  def move_cart_products
    cart_products_list = self.customer.cart_products.map do |cart_product|
      {
        product_id: cart_product.product_id,
        tax_included_price: cart_product.product.add_tax_included_price,
        quantity: cart_product.quantity
      }
    end
    self.order_products.create(cart_products_list)
    self.customer.cart_products.destroy_all
  end

  def check_order_status
    if self.order_status == "confirmed_payment"
      self.order_products.update_all(make_status: "wating_for_make")
    end
  end
 
end
