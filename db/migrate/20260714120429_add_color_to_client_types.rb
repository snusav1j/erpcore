class AddColorToClientTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :client_types, :color, :string
  end
end