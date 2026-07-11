class RemovePositionFromCustomFields < ActiveRecord::Migration[8.0]
  def change
    remove_column :custom_fields, :position, :integer
  end
end