class AddColorToInteractionStatuses < ActiveRecord::Migration[8.0]
  def change
    add_column :interaction_statuses, :color, :string
  end
end