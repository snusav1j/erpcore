class CustomFieldsController < ApplicationController
  before_action :get_columns, only: [:index, :create, :update]

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

    if @created
      @entity = @custom_field.entity
      model = @entity.constantize.all
      @column = @custom_field.table_column_data(model)
      @custom_fields = CustomField.for_entity(@entity)
    end
    respond_to :js
  end

  def update
    @custom_field = CustomField.find(params[:id])

    @updated = @custom_field.update(custom_field_params)

    @entity = @custom_field.entity
    @custom_fields = CustomField.for_entity(@entity)

    if @updated
      model = @entity.constantize.all
      @column = @custom_field.table_column_data(model)
      @custom_fields = CustomField.for_entity(@entity)
    end

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

  def get_model(entity=nil)
    return nil unless entity
    @model = entity.constantize.all
  end

  def get_columns
    @columns = Client.table_columns
  end

  def custom_field_params
    params.require(:custom_field).permit!
  end

end