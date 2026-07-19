class InteractionsController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]
  before_action :get_custom_fields, only: [:new_modal, :edit_modal, :index]

  def index
    get_interactions
  end

  def show
    @interaction = Interaction.find(params[:id])
  end

  def new_modal
    @interaction = Interaction.new
    
    respond_to :js
  end

  def edit_modal
    @interaction = Interaction.find(params[:id])
    
    respond_to :js
  end

  def create
    @interaction = current_company.interactions.new(interaction_params)
    @interaction.manager_id = current_user.id
    
    @created = @interaction.save

    if @created
      CustomFieldsHandler.new(@interaction, params, current_company).save
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


  def get_columns
    @columns = Interaction.table_columns(current_company)
  end

  def interaction_params
    params.require(:interaction).permit!
  end

end