class OrdersController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]

  def index
    get_orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new_modal
    @order = Order.new
    respond_to :js
  end

  def edit_modal
    @order = Order.find(params[:id])
    respond_to :js
  end

  def create
    @order = Order.new(order_params)
    @order.manager_id = current_user.id
    @created = @order.save

    @order.client.update(status: Client::CLIENT_STATUS_ACTIVE) if @created
    
    get_orders
    respond_to :js
  end

  def update
    @order = Order.find(params[:id])
    @updated = @order.update(order_params)

    get_orders
    respond_to :js
  end

  def destroy
    @order = Order.find(params[:id])
    @destroyed = @order.destroy

    get_orders
    respond_to :js
  end

  private
  
  def get_orders
    @orders = current_company&.orders
  end

  def get_columns
    @columns = Order.table_columns
  end

  def order_params
    params.require(:order).permit!
  end

end