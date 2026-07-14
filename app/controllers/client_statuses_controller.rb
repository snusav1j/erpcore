class ClientStatusesController < ApplicationController

  def index
    @client_statuses = current_company.client_statuses
  end

  def show
    @client_status = current_company.client_statuses.find(params[:id])
  end

  def new_modal
    @client_status = ClientStatus.new
    respond_to :js
  end

  def edit_modal
    @client_status = current_company.client_statuses.find(params[:id])
    respond_to :js
  end

  def create
    @client_status = current_company.client_statuses.new(client_status_params)
    @created = @client_status.save

    @client_statuses = current_company.client_statuses
    respond_to :js
  end

  def update
    @client_status = current_company.client_statuses.find(params[:id])
    @updated = @client_status.update(client_status_params)

    @client_statuses = current_company.client_statuses
    respond_to :js
  end

  def destroy
    @client_status = current_company.client_statuses.find(params[:id])
    @destroyed = @client_status.destroy

    @client_statuses = current_company.client_statuses
    respond_to :js
  end

  private

  def client_status_params
    params.require(:client_status).permit!
  end

end