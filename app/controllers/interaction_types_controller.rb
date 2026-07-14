class InteractionTypesController < ApplicationController

  def index
    @interaction_types = current_company.interaction_types
  end

  def show
    @interaction_type = current_company.interaction_types.find(params[:id])
  end

  def new_modal
    @interaction_type = InteractionType.new
    respond_to :js
  end

  def edit_modal
    @interaction_type = current_company.interaction_types.find(params[:id])
    respond_to :js
  end

  def create
    @interaction_type = current_company.interaction_types.new(interaction_type_params)
    @created = @interaction_type.save

    @interaction_types = current_company.interaction_types
    respond_to :js
  end

  def update
    @interaction_type = current_company.interaction_types.find(params[:id])
    @updated = @interaction_type.update(interaction_type_params)

    @interaction_types = current_company.interaction_types
    respond_to :js
  end

  def destroy
    @interaction_type = current_company.interaction_types.find(params[:id])
    @destroyed = @interaction_type.destroy

    @interaction_types = current_company.interaction_types
    respond_to :js
  end

  private

  def interaction_type_params
    params.require(:interaction_type).permit!
  end

end