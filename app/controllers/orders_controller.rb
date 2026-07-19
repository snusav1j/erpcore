class OrdersController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]
  before_action :get_custom_fields, only: [:new_modal, :edit_modal, :index]

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
    @order = current_company.orders.new(order_params)
    @order.manager_id = current_user.id
    
    @created = @order.save
    CustomFieldsHandler.new(@order, params, current_company).save if @created
    
    respond_to :js
  end

  def update
    @order = Order.find(params[:id])
    @updated = @order.update(order_params)
    CustomFieldsHandler.new(@order, params, current_company).save if @updated

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

  def get_custom_fields
    @custom_fields = CustomField.visible_for_entity(:order, current_company)
  end

  def get_orders
    @orders = current_company&.orders
  end

  def get_columns
    @columns = Order.table_columns(current_company)
  end

  def order_params
    params.require(:order).permit!
  end

end