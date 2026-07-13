class ChangeCustomFieldsUniqueIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :custom_fields, [:entity, :key]

    add_index :custom_fields, [:company_id, :entity, :key], unique: true
  end
end