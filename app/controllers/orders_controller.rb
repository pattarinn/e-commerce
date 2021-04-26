class OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :new, :create]

  def index
    @orders = Order.all
    @orders = @orders.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @product = Product.find(params["product_id"])
  end

  def edit
    @order = Order.find(params[:id])
    @product = Product.find(@order.product_id)
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