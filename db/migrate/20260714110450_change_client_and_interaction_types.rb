class ChangeClientAndInteractionTypes < ActiveRecord::Migration[8.0]
  def change
    rename_column :clients, :status, :status_id

    remove_column :clients, :client_type, :integer
    add_reference :clients, :client_type, foreign_key: true

    remove_column :interactions, :interaction_type, :string
    remove_column :interactions, :status, :string

    add_reference :interactions, :interaction_type, foreign_key: true
    add_reference :interactions, :interaction_status, foreign_key: true
  end
end