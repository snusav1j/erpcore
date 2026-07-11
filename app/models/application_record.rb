class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class_attribute :custom_fields_enabled, default: false

  has_many :custom_field_values, as: :entity, dependent: :destroy

  def custom_fields
    CustomField.for_entity(self.class.name)
  end

  def custom_value(code)
    CustomField.value_for(entity: self.class.name, object: self, code: code)
  end
  
  def self.table_columns

    ignore_columns = %w[created_at updated_at]

    columns = []

    self.column_names.each do |column|
      next if ignore_columns.include?(column)

      columns << {
        key: column.to_sym,
        label: column.humanize,
        position: TableSetting.position(
          entity: self.name,
          column_key: column
        )
      }
    end

    CustomField.for_entity(self.name).each do |field|

      columns << {
        key: field.code.to_sym,
        label: field.label,
        custom: true,
        position: TableSetting.position(
          entity: self.name,
          column_key: field.code
        )
      }

    end

    columns.sort_by { |column| column[:position] }

  end

  def table_value(column)

    return custom_value(column) if custom_field?(column)

    send(column)

  end

  private

  def custom_field?(column)

    CustomField.exists?(
      entity: self.class.name,
      code: column.to_s
    )

  end

end