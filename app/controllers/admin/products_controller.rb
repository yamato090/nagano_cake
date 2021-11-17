class Admin::ProductsController < ApplicationController
  layout 'admin'
  def index
    @products = Product.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end

    private
    def product_params
      params.require(:product).permit(:genre_id, :name, :detail, :image, :tax_excluded_price, :is_active)
    end
end
