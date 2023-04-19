class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(id: :desc).page(params[:page])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(amount: params[:order][:amount])
    @order.user = current_user
    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  def revoke
    order = current_user.orders.find(params[:order_id])
    if order.may_revoke?
      order.revoke!
      flash[:notice] = 'Order revoked'
    else
      flash[:notice] = "Order can't revoked"
    end
    redirect_to orders_path
  end
end
