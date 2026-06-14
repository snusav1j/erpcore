class InteractionsController < ApplicationController

  def index
    @interactions = Interaction.all
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
    @created = @interaction.save

    @interactions = Interaction.all
    respond_to :js
  end

  def update
    @interaction = Interaction.find(params[:id])
    @updated = @interaction.update(interaction_params)

    @interactions = Interaction.all
    respond_to :js
  end

  def destroy
    @interaction = Interaction.find(params[:id])
    @interaction.destroy

    @interactions = Interaction.all
    respond_to :js
  end

  private

  def interaction_params
    params.require(:interaction).permit!
  end

end