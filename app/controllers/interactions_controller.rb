class InteractionsController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]

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
    @interaction = Interaction.new(interaction_params)
    
    @interaction.manager_id = current_user.id
    @client.company_id = current_company.id
    
    @created = @interaction.save

    @interaction.client.update(status: Client::CLIENT_STATUS_POTENTIAL) if @created
    
    get_interactions
    respond_to :js
  end

  def update
    @interaction = Interaction.find(params[:id])
    @updated = @interaction.update(interaction_params) if current_user.can_interact_with_client?(@interaction.client)

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

  def get_interactions
    @interactions = current_company&.interactions
  end


  def get_columns
    @columns = Interaction.table_columns
  end

  def interaction_params
    params.require(:interaction).permit!
  end

end