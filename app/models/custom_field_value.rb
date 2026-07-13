class CustomFieldValue < ApplicationRecord

  belongs_to :company
  belongs_to :custom_field
  belongs_to :entity, polymorphic: true

  def self.save_value(entity:, object:, field_id:, value:)

    value_record = object.custom_field_values
      .find_or_initialize_by(
        custom_field_id: field_id,
        company: object.company
      )

    value_record.value = value
    value_record.company = object.company
    value_record.save!

    value_record

  end

end