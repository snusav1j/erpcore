class RenameCodeToKeyInCustomFields < ActiveRecord::Migration[8.0]
  def change
    rename_column :custom_fields, :code, :key
  end
end