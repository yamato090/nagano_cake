class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new
    @delivery = Delivery.new
  end

  def check
    @order = current_customer.orders.new
    @order.payment_method = params[:payment_method]
    @order.postage = 800
    @order.total_price = current_customer.cart_products_total_price + @order.postage

    receiver =
    case @address_type = params[:address_type].to_i
    when 1 # ご自身の住所
      current_customer
    when 2 # 登録済み住所から選択
      current_customer.deliveries.find(params[:delivery_id])
    when 3 # 新しいお届け先
      @delivery = current_customer.deliveries.new(delivery_params)
      unless @delivery.save
        flash[:alert] = '住所が正しくありません'
        render :new
        return
      else
        @delivery
      end
    else
    end
    @order.set_receiver(receiver)
  end
  
  def create
    current_customer.orders.create(order_params)
    redirect_to complete_orders_path
  end

  def index
  end

  def show
  end

  def complete
  end



  private

  def order_params
    params.require(:order).permit(:name, :payment_method, :postal_code, :address, :total_price)
  end
  
  def delivery_params
    params.permit(:name,:address,:postal_code)
  end

  def check_cart_is_not_empty
    redirect_to products_path unless current_customer.cart_products.present?
  end
end
