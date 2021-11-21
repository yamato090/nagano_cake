class Public::CartProductsController < ApplicationController

  def create
    @cart_product = current_customer.cart_products.find_by(product_id: params[:product_id])

    if @cart_product.present?
      @cart_product.quantity += params[:quantity].to_i
    else
      @cart_product = current_customer.cart_products.new(cart_product_params)
    end

    if @cart_product.save
      redirect_to cart_products_path, notice: '商品を追加しました'
    else
      flash[:alert] = '商品を追加できませんでした'
      redirect_to request.referer
    end
  end

  def index
    @cart_products = current_customer.cart_products.all
    @total = @cart_products.inject(0) { |sum, product| sum + product.sum_of_price }
  end

  def update
    @cart_product = CartProduct.find(params[:id])
    @cart_product.update(cart_product_params)
    redirect_to cart_products_path, notice: '数量を変更しました'
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path, notice: '商品を削除しました'
  end

  def destroy_all
    @cart_products = current_customer.cart_products.all
    @cart_products.destroy_all
    redirect_to cart_products_path,notice: '全ての商品を削除しました'
  end

  def cart_product_params
    params.permit(:product_id,:quantity)
  end
end
