class ChangeEntityToPolymorphicInCustomFieldValues < ActiveRecord::Migration[8.0]
  def change
    rename_column :custom_field_values, :entity, :entity_type

    remove_index :custom_field_values,
                 [:entity_type, :entity_id],
                 if_exists: true

    add_index :custom_field_values,
              [:entity_type, :entity_id],
              name: "index_custom_field_values_on_entity"
  end
end