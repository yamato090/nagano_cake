class Admin::HomesController < ApplicationController
  layout 'admin'

  def top
    @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end
