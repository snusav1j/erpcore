class InteractionStatusesController < ApplicationController

  def index
    @interaction_statuses = current_company.interaction_statuses
  end

  def show
    @interaction_status = current_company.interaction_statuses.find(params[:id])
  end

  def new_modal
    @interaction_status = InteractionStatus.new
    respond_to :js
  end

  def edit_modal
    @interaction_status = current_company.interaction_statuses.find(params[:id])
    respond_to :js
  end

  def create
    @interaction_status = current_company.interaction_statuses.new(interaction_status_params)
    @created = @interaction_status.save

    @interaction_statuses = current_company.interaction_statuses
    respond_to :js
  end

  def update
    @interaction_status = current_company.interaction_statuses.find(params[:id])
    @updated = @interaction_status.update(interaction_status_params)

    @interaction_statuses = current_company.interaction_statuses
    respond_to :js
  end

  def destroy
    @interaction_status = current_company.interaction_statuses.find(params[:id])
    @destroyed = @interaction_status.destroy

    @interaction_statuses = current_company.interaction_statuses
    respond_to :js
  end

  private

  def interaction_status_params
    params.require(:interaction_status).permit!
  end

end