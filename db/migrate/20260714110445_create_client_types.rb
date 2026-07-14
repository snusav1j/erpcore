class CreateClientTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :client_types do |t|
      t.string :name, null: false

      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :client_types, [:company_id, :name], unique: true
  end
end