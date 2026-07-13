class ApplicationRecord < ActiveRecord::Base

  primary_abstract_class

  class_attribute :custom_fields_enabled, default: false

  has_many :custom_field_values, as: :entity, dependent: :destroy

  def custom_fields
    CustomField.for_entity(self.class.name, company)
  end

  def custom_value(key)
    CustomField.value_for(entity: self.class.name, object: self, key: key, company: company)
  end
    
  def self.table_columns(company = nil)
    ignore_columns = %w[created_at updated_at]

    return [] unless company
    columns = []

    self.column_names.each do |column|
      next if ignore_columns.include?(column)

      columns << {
        key: column.to_sym,
        label: I18n.t(
          "activerecord.attributes.#{self.model_name.i18n_key}.#{column}",
          default: column.humanize
        ),
        position: company ? TableSetting.position(
          entity: self.name,
          column_key: column,
          company: company
        ) : 0
      }
    end

    if company
      CustomField.for_entity(self.name, company).each do |field|
        columns << {
          key: field.key.to_sym,
          label: field.label,
          custom: true,
          position: TableSetting.position(
            entity: self.name,
            column_key: field.key,
            company: company
          )
        }
      end
    end

    columns.sort_by { |column| column[:position] }
  end

  def table_value(column)

    return custom_value(column) if custom_field?(column)

    send(column)

  end

  private

  def custom_field?(column)
    CustomField.exists?(entity: self.class.name, key: column.to_s, company: company)
  end

end