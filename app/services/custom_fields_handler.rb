class CustomFieldsHandler

  def initialize(entity, params, company)
    @entity = entity
    @params = params
    @company = company
  end


  def save
    return unless @params[:custom_fields]

    @params[:custom_fields].each do |field_id, value|

      value = value.last if value.is_a?(Array)

      field = CustomField.find_by(
        id: field_id,
        company: @company
      )

      next unless field
      next unless field.entity == @entity.class.name


      @entity.custom_field_values
        .find_or_initialize_by(
          custom_field_id: field.id
        )
        .update!(
          value: value,
          company: @company
        )

    end
  end

end