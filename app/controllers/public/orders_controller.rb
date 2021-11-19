class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new
    @delivery = Delivery.new
  end

  def check
  end

  def index
  end

  def show
  end

  def complete
  end
  
  
  
  private

  def delivery_params
    params.require(:delivery).permit(:name,:address,:postal_code)
  end

  def order_params
    params.require(:order).permit(:name, :address, :postal_code, :total_price, :payment_method)
  end

  def check_cart_is_not_empty
    redirect_to items_path unless current_customer.cart_products.present?
  end
end
