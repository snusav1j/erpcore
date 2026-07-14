class CustomFieldsController < ApplicationController
  def index
    get_custom_fields
  end

  def index_modal
    @entity = params[:entity]
    @custom_fields = CustomField.for_entity(@entity, current_company)

    respond_to :js
  end

  def new_modal
    @entity = params[:entity]
    @custom_field = CustomField.new(entity: @entity, company_id: current_company.id)

    respond_to :js
  end

  def edit_modal
    @custom_field = CustomField.find_by!(id: params[:id], company: current_company)
    @entity = @custom_field.entity

    respond_to :js
  end

  def create
    @custom_field = CustomField.new(custom_field_params)
    @custom_field.company = current_company
    @created = @custom_field.save

    if @created
      @entity = @custom_field.entity
      model = @entity.constantize.where(company: current_company)
      @column = @custom_field.table_column_data(model, company: current_company)
      @custom_fields = CustomField.for_entity(@entity, current_company)
    end
    respond_to :js
  end

  def update
    @custom_field = CustomField.find_by!(id: params[:id], company: current_company)

    @updated = @custom_field.update(custom_field_params)

    @entity = @custom_field.entity
    @custom_fields = CustomField.for_entity(@entity, current_company)

    if @updated
      model = @entity.constantize.where(company: current_company)
      @column = @custom_field.table_column_data(model, company: current_company)
      @custom_fields = CustomField.for_entity(@entity, current_company)
    end

    respond_to :js
  end

  def destroy
    @custom_field = CustomField.find_by!(id: params[:id], company: current_company)
    @entity = @custom_field.entity

    @destroyed = @custom_field.destroy
    @custom_fields = CustomField.for_entity(@entity, current_company)

    respond_to :js
  end

  private

  def get_model(entity=nil)
    return nil unless entity
    @model = entity.constantize.all
  end

  def get_custom_fields
    @custom_fields = CustomField.for_company(current_company)
  end

  def custom_field_params
    params.require(:custom_field).permit!
  end

end