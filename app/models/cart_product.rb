class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer


  def total_price
    product.add_tax_included_price * quantity
  end
end
