class CustomFieldsController < ApplicationController

  def index
    @custom_fields = CustomField.all
  end

  def index_modal
    @entity = params[:entity]
    @custom_fields = CustomField.for_entity(@entity)

    respond_to :js
  end

  def new_modal
    @entity = params[:entity]

    @custom_field = CustomField.new(entity: @entity)

    respond_to :js
  end

  def edit_modal
    @custom_field = CustomField.find(params[:id])
    @entity = @custom_field.entity

    respond_to :js
  end

  def create
    @custom_field = CustomField.new(custom_field_params)
    @created = @custom_field.save

    @entity = @custom_field.entity
    @custom_fields = CustomField.for_entity(@entity)

    respond_to :js
  end

  def update
    @custom_field = CustomField.find(params[:id])
    @updated = @custom_field.update(custom_field_params)

    @entity = @custom_field.entity
    @custom_fields = CustomField.for_entity(@entity)

    respond_to :js
  end

  def destroy
    @custom_field = CustomField.find(params[:id])
    @entity = @custom_field.entity

    @destroyed = @custom_field.destroy
    @custom_fields = CustomField.for_entity(@entity)

    respond_to :js
  end

  private

  def custom_field_params
    params.require(:custom_field).permit(:entity, :code, :label, :field_type, :required)
  end

end