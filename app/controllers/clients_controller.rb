class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_action
  before_action :get_columns, only: [:index, :create, :update]
  before_action :get_custom_fields, only: [:new_modal, :edit_modal, :index]

  def index
    get_clients
  end

  def show
    @client = current_user.company.clients.find(params[:id])
  end


  def new_modal
    @client = Client.new

    respond_to :js
  end


  def edit_modal
    @client = current_user.company.clients.find(params[:id])

    respond_to :js
  end


  def create
    @client = current_company.clients.new(client_params)
    
    @client.manager_id = current_user.id

    @created = @client.save

    CustomFieldsHandler.new(@client, params, current_company).save if @created
    Rails.logger.debug @client.errors.full_messages

    get_clients

    respond_to :js
  end


  def update
    @client = current_user.company.clients.find(params[:id])

    @updated = @client.update(client_params) if current_user.can_interact_with_client?(@client)

    CustomFieldsHandler.new(@client, params, current_company).save if @updated

    get_clients

    respond_to :js
  end

  def destroy
    @client = current_user.company.clients.find(params[:id])
    @destroyed = @client.destroy

    get_clients

    respond_to :js
  end

  private

  def get_custom_fields
    @custom_fields = CustomField.visible_for_entity(:client, current_company)
  end

  def authorize_action
    authorize @client || Client
  end

  def get_clients
    @clients = current_company&.clients
  end

  def get_columns
    @columns = Client.table_columns(current_company)
  end

  def client_params
    params.require(:client).permit!
  end

end