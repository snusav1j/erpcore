class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
  end

  def new_modal
    @client = Client.new
    respond_to :js
  end

  def edit_modal
    @client = Client.find(params[:id])
    respond_to :js
  end

  def create
    @client = Client.new(client_params)
    @created = @client.save

    @clients = Client.all
    respond_to :js
  end

  def update
    @client = Client.find(params[:id])
    @updated = @client.update(client_params)

    @clients = Client.all
    respond_to :js
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    @clients = Client.all
    respond_to :js
  end

  private

  def client_params
    params.require(:client).permit!
  end

end