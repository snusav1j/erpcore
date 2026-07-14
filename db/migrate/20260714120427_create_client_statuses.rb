class CreateClientStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :client_statuses do |t|
      t.string :name, null: false
      t.string :color
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :client_statuses, [:company_id, :name], unique: true


  end
end