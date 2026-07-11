class TableSettingsController < ApplicationController

  def update_positions
    TableSetting.update_positions(entity: params[:entity],columns: params[:columns])
    respond_to :js
  end

end