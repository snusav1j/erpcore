class CustomFieldsHandler

  def initialize(entity, params)
    @entity = entity
    @params = params
  end


  def save
    return unless @params[:custom_fields]

    @params[:custom_fields].each do |field_id, value|

      field = CustomField.find_by(id: field_id)

      next unless field
      next unless field.entity == @entity.class.name


      @entity.custom_field_values
        .find_or_initialize_by(
          custom_field_id: field.id
        )
        .update!(
          value: value
        )

    end
  end

end