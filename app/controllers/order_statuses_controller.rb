class OrderStatusesController < ApplicationController

  def index
    @order_statuses = current_company.order_statuses
  end

  def show
    @order_status = current_company.order_statuses.find(params[:id])
  end

  def new_modal
    @order_status = OrderStatus.new
    respond_to :js
  end

  def edit_modal
    @order_status = current_company.order_statuses.find(params[:id])
    respond_to :js
  end

  def create
    @order_status = current_company.order_statuses.new(order_status_params)
    @created = @order_status.save

    @order_statuses = current_company.order_statuses
    respond_to :js
  end

  def update
    @order_status = current_company.order_statuses.find(params[:id])
    @updated = @order_status.update(order_status_params)

    @order_statuses = current_company.order_statuses
    respond_to :js
  end

  def destroy
    @order_status = current_company.order_statuses.find(params[:id])
    @destroyed = @order_status.destroy

    @order_statuses = current_company.order_statuses
    respond_to :js
  end

  private

  def order_status_params
    params.require(:order_status).permit!
  end

end