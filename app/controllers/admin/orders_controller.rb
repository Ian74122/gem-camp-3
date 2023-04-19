class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.order(id: :desc).page(params[:page])
  end

  def submit
    order = Order.find(params[:order_id])
    if order.may_submit?
      order.submit!
      flash[:notice] = 'Order submitted'
    else
      flash[:notice] = "Order can't submitted"
    end
    redirect_to admin_orders_path
  end

  def revoke
    order = Order.find(params[:order_id])
    if order.may_revoke?
      order.revoke!
      flash[:notice] = 'Order revoked'
    else
      flash[:notice] = "Order can't revoked"
    end
    redirect_to admin_orders_path
  end

  def pay
    order = Order.find(params[:order_id])
    if order.may_pay?
      order.pay!
      flash[:notice] = 'Order paid'
    else
      flash[:notice] = "Order can't pay"
    end
    redirect_to admin_orders_path
  end

  def check_admin
    raise ActionController::RoutingError.new('Not Found') unless current_user.admin?
  end
end
