class AddColorToInteractionTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :interaction_types, :color, :string
  end
end