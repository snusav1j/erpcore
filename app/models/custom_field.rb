class CustomField < ApplicationRecord
  
  belongs_to :company
  has_many :custom_field_values, dependent: :destroy

  FIELD_TYPE_COLLECTION = [
                            ['Строка', 'string'],
                            ['Текст', 'text'],
                            ['Число', 'number'],
                            ['Да/Нет', 'boolean'],
                            ['Дата', 'date'],
                          ]

  def self.available_entities
    Rails.application.eager_load! if Rails.env.development?

    ApplicationRecord
      .descendants
      .select(&:custom_fields_enabled)
      .sort_by(&:name)
      .map do |model|

        [
          model.model_name.human,
          model.name
        ]

      end
  end

  def self.entities
    ENTITIES.map do |key, value|
      [value, key]
    end
  end
  
  def self.for_entity(entity, company)
    return none unless company

    where(
      entity: entity.to_s.classify,
      company_id: company.id
    )
  end
  
  def self.visible_for_entity(entity, company)
    return none unless company

    fields = where(entity: entity.to_s.classify, company_id: company.id)

    fields.select do |field|
      TableSetting.visible?(entity: field.entity, column_key: field.key, company: company)
    end
  end
  
  def self.create_field(entity:, key:, label:, field_type:, required: false, company:)
    self.create!(
      entity: entity.to_s.classify,
      key: key,
      label: label,
      field_type: field_type,
      required: required,
      company: company
    )
  end

  def self.value_for(entity:, object:, key:, company:)
    field = self.find_by(
      entity: entity.to_s.classify,
      key: key,
      company_id: company.id
    )
    return nil unless field

    object.custom_field_values.find_by(custom_field_id: field.id)&.value
  end

  def table_column_data(records = [], company:)
    {
      key: self.key,
      label: self.label,
      position: TableSetting.position(
        entity: self.entity,
        column_key: self.key,
        company: company
      ),
      custom: true,
      cells: records.map do |record|
        {
          id: record.id,
          value: record.custom_value(key)
        }
      end
    }
  end

  def self.table_column_data(id:, records: [])
    field = self.find(id)
    field.table_column_data(records)
  end


end