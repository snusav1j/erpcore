class ProductsController < ApplicationController

  def index
    @products = Product.all
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
    @product = Product.new(product_params)
    @product.manager_id = current_user.id

    @created = @product.save

    @products = Product.all
    respond_to :js
  end

  def update
    @product = Product.find(params[:id])

    @updated = @product.update(product_params)

    @products = Product.all
    respond_to :js
  end

  def destroy
    @product = Product.find(params[:id])

    @destroyed = @product.destroy

    @products = Product.all
    respond_to :js
  end

  private

  def product_params
    params.require(:product).permit!
  end

end