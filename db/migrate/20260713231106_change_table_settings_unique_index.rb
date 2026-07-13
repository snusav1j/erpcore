class ChangeTableSettingsUniqueIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :table_settings, [:entity, :column_key]

    add_index :table_settings, [:company_id, :entity, :column_key], unique: true
  end
end