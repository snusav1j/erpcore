class AddColumnVisibilityBlockStateToUserSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :user_settings, :column_visibility_block_state, :boolean
  end
end
