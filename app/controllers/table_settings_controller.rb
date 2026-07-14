class TableSettingsController < ApplicationController
  
  def index_modal
    @entity = params[:entity]
    @custom_fields = CustomField.for_entity(@entity, current_company)
    @columns = @entity.constantize.table_columns(current_company)

    respond_to :js
  end

  def update_positions
    @entity = params[:entity]
    @columns = params[:columns]
    TableSetting.update_positions(entity: @entity, columns: @columns, company: current_company)
    respond_to :js
  end

  def update_visibility
    @entity = params[:entity]
    @column_key = params[:column_key]
    @visible = param_b(:visible)

    @column = @entity.constantize.table_columns(current_company).find { |column| column[:key].to_s == @column_key }

    @table_setting = current_company.table_settings.find_or_initialize_by(entity: @entity, column_key: @column_key)

    @updated = @table_setting.update(visible: @visible)

    respond_to :js
  end
end