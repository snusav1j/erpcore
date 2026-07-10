class CreateCustomFields < ActiveRecord::Migration[8.0]

  def change

    create_table :custom_fields do |t|

      # client, product, order
      t.string :entity,
        null: false


      # системный код
      # inn, vat_number, color
      t.string :code,
        null: false


      # отображаемое имя
      t.string :label,
        null: false


      # string, number, date, select
      t.string :field_type,
        null: false


      t.boolean :required,
        default: false


      t.integer :position,
        default: 0


      t.timestamps

    end


    create_table :custom_field_values do |t|

      t.references :custom_field,
        null: false,
        foreign_key: true


      # client/product/order
      t.string :entity,
        null: false


      # id записи
      t.bigint :entity_id,
        null: false


      t.text :value


      t.timestamps

    end


    add_index :custom_fields,
      [:entity, :code],
      unique: true


    add_index :custom_field_values,
      [:entity, :entity_id]


  end

end