class OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :new, :create]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.create(order_params)
    redirect_to @order
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_path
  end



  private
  def order_params
    params.require(:order).permit(:product_name, :customer_name, :address, :amount, :product_id)
  end
end