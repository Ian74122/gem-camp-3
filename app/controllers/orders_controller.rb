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

end
