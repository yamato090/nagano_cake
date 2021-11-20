class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  enum making_status: { not_startable: 0,  wating_for_make: 1, making: 2, completed: 3 }

  def sum_of_price
    (self.tax_included_price * self.quantity).round
  end

  private
  def order_making_status
    if self.making_status == "making"
      self.order.update(order_detail: "making")
    elsif self.making_status == "completed"
      if self.order.order_products.all? { |order_product| order_product.making_status == "completed" }
        self.order.update(order_detail: "preparing_to_ship")
      end
    end
  end
  
end
