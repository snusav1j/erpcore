class ProductsController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]
  before_action :get_custom_fields, only: [:new_modal, :edit_modal, :index]

  def index
    get_products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new_modal
    @product = Product.new
    
    respond_to :js
  end

  def edit_modal
    @product = Product.find(params[:id])
    
    respond_to :js
  end

  def create
    @product = current_company.products.new(product_params)
    
    @product.manager_id = current_user.id

    @created = @product.save
    CustomFieldsHandler.new(@product, params, current_company).save if @created

    get_products
    respond_to :js
  end

  def update
    @product = Product.find(params[:id])

    @updated = @product.update(product_params)
    CustomFieldsHandler.new(@product, params, current_company).save if @updated

    get_products
    respond_to :js
  end

  def destroy
    @product = Product.find(params[:id])

    @destroyed = @product.destroy

    get_products
    respond_to :js
  end

  private

  def get_custom_fields
    @custom_fields = CustomField.visible_for_entity(:product, current_company)
  end

  def get_products
    @products = current_company&.products
  end

  def get_columns
    @columns = Product.table_columns(current_company)
  end

  def product_params
    params.require(:product).permit!
  end

end