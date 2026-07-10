class OrdersController < ApplicationController

  def index
    @orders = Order.all
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
    
    @orders = Order.all
    respond_to :js
  end

  def update
    @order = Order.find(params[:id])
    @updated = @order.update(order_params)

    @orders = Order.all
    respond_to :js
  end

  def destroy
    @order = Order.find(params[:id])
    @destroyed = @order.destroy

    @orders = Order.all
    respond_to :js
  end

  private

  def order_params
    params.require(:order).permit!
  end

end