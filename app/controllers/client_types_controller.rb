class ClientTypesController < ApplicationController

  def index
    @client_types = current_company.client_types
  end

  def show
    @client_type = current_company.client_types.find(params[:id])
  end

  def new_modal
    @client_type = ClientType.new
    respond_to :js
  end

  def edit_modal
    @client_type = current_company.client_types.find(params[:id])
    respond_to :js
  end

  def create
    @client_type = current_company.client_types.new(client_type_params)
    @created = @client_type.save

    @client_types = current_company.client_types
    respond_to :js
  end

  def update
    @client_type = current_company.client_types.find(params[:id])
    @updated = @client_type.update(client_type_params)

    @client_types = current_company.client_types
    respond_to :js
  end

  def destroy
    @client_type = current_company.client_types.find(params[:id])
    @destroyed = @client_type.destroy

    @client_types = current_company.client_types
    respond_to :js
  end

  private

  def client_type_params
    params.require(:client_type).permit!
  end

end