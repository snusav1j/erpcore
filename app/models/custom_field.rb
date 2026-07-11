class CustomField < ApplicationRecord

  has_many :custom_field_values,
           dependent: :destroy

  ENTITIES = {
    "Client" => "Клиенты",
    "Product" => "Товары",
    "Order" => "Заказы",
    "Interaction" => "Взаимодействия"
  }

  FIELD_TYPE_COLLECTION = [
                            ['Строка', 'string'],
                            ['Текст', 'text'],
                            ['Число', 'number'],
                            ['Дата', 'date']
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
  
  # Получить поля для сущности
  def self.for_entity(entity)

    where(
      entity: entity.to_s.classify
    )

  end


  # Создать новое поле
  def self.create_field(entity:, code:, label:, field_type:, required: false)

    create!(
      entity: entity.to_s.classify,
      code: code,
      label: label,
      field_type: field_type,
      required: required
    )

  end


  # Получить значение поля у объекта
  def self.value_for(entity:, object:, code:)

    field = find_by(
      entity: entity.to_s.classify,
      code: code
    )

    return nil unless field

    object.custom_field_values
      .find_by(custom_field_id: field.id)
      &.value

  end

end