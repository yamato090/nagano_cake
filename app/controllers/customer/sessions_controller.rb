# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def customer_state
    @customer = Customer.find_by(email: parms[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password])
      ## 【処理内容3】
      # if customer.nil?
      #   redirect_to new_customer_session_path
      # elsif customer.is_deleted == true
      #   flash[:notice] = "退会済みのアカウントです"
      #   redirect_to new_customer_session_path
      # end
    end
  end
  
end
