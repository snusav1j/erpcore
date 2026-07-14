class AddCustomFieldsBlockStateToUserSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :user_settings, :custom_fields_block_state, :boolean
  end
end
