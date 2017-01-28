class CartsController < ApplicationController
  def show
  	@user = current_user
  	@order_items = current_order.order_items
  end
end
