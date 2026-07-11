class ClientsController < ApplicationController

  def index
    @clients = current_user.clients
    @columns = Client.table_columns
  end

  def show
    @client = Client.find(params[:id])
  end


  def new_modal
    @client = Client.new
    @custom_fields = CustomField.for_entity(:client)

    respond_to :js
  end


  def edit_modal
    @client = Client.find(params[:id])
    @custom_fields = CustomField.for_entity(:client)

    respond_to :js
  end


  def create
    @client = Client.new(client_params)
    @client.manager_id = current_user.id

    @created = @client.save

    CustomFieldsHandler.new(@client, params).save if @created

    @clients = Client.all

    respond_to :js
  end


  def update
    @client = Client.find(params[:id])

    @updated = @client.update(client_params) if current_user.can_interact_with_client?(@client)

    CustomFieldsHandler.new(@client, params).save if @updated

    @clients = Client.all

    respond_to :js
  end


  def destroy
    @client = Client.find(params[:id])
    @destroyed = @client.destroy

    @clients = Client.all

    respond_to :js
  end


  private

  def client_params
    params.require(:client).permit!
  end

end