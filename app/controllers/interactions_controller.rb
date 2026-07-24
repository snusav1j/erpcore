class InteractionsController < ApplicationController
  before_action :get_client_columns, only: [:create]
  before_action :get_columns, only: [:new_modal, :edit_modal, :index, :create, :update]
  before_action :get_custom_fields, only: [:new_modal, :edit_modal, :index]

  def index
    get_interactions
  end

  def show
    @interaction = Interaction.find(params[:id])
  end

  def new_modal
    @interaction = Interaction.new
    @interaction.client_id = params[:client_id]
    @client = @interaction&.client
    @client_interactions = @client&.interactions
    respond_to :js
  end

  def edit_modal
    @interaction = Interaction.find(params[:id])
    @client = @interaction&.client
    @client_interactions = @client&.interactions
    respond_to :js
  end

  def create
    @interaction = current_company.interactions.new(interaction_params)
    @interaction.manager_id = current_user.id
    @created = @interaction.save
    
    if @created
      CustomFieldsHandler.new(@interaction, params, current_company).save
      @client = @interaction.client
    end
    
    get_interactions
    respond_to :js
  end

  def update
    @interaction = Interaction.find(params[:id])
    @updated = @interaction.update(interaction_params) if current_user.can_interact_with_client?(@interaction.client)
    CustomFieldsHandler.new(@interaction, params, current_company).save if @updated

    get_interactions
    respond_to :js
  end

  def destroy
    @interaction = Interaction.find(params[:id])
    @destroyed = @interaction.destroy

    get_interactions
    respond_to :js
  end

  private

  def get_custom_fields
    @custom_fields = CustomField.visible_for_entity(:interaction, current_company)
  end

  def get_interactions
    @interactions = current_company&.interactions
  end

  def get_client_columns
    @client_columns = Client.table_columns(current_company)
  end

  def get_columns
    @columns = Interaction.table_columns(current_company)
  end

  def interaction_params
    params.require(:interaction).permit!
  end

end