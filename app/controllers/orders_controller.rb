class OrdersController < ApplicationController
	require "stripe"
	before_action :set_stripe_token

	def destroy
	  current_order.destroy
	  session[:order_id] = nil
	  redirect_to root_path, :notice => "Basket emptied successfully."
	end

	def checkout
	  @order = Shoppe::Order.find(current_order.id)
	  if request.patch?
	    if @order.proceed_to_confirm(params[:order].permit(:first_name, :last_name, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number))
	      redirect_to checkout_payment_path
	    end
	  end
	end

	def payment
	  # @order = Shoppe::Order.find(session[:order_id])
	  @order = Shoppe::Order.find(current_order.id)
	  if request.post?
	    if @order.accept_stripe_token(params[:stripe_token])
	      redirect_to checkout_confirmation_path
	    else
	      flash.now[:notice] = "Could not exchange Stripe token. Please try again."
	    end
	  end
	end

	def confirmation
	  if request.post?
	    current_order.confirm!
	    session[:order_id] = nil
	    redirect_to root_path, :notice => "Order has been placed successfully!"
	  end
	end

	private
	def set_stripe_token
		params[:stripe_token] ||= exchange_card_details_for_token
	end

	def exchange_card_details_for_token

		Stripe.api_key = "sk_test_PRWdmf3VrNRv2m6D6gA58dyn"
		card_details = {
			number: params
		}

		Stripe::Token.create(
		  :card => {
		    :number => "4242424242424242",
		    :exp_month => 4,
		    :exp_year => 2018,
		    :cvc => "314"
		  },
		)

	end

end
