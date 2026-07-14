class CreateInteractionStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :interaction_status do |t|
      t.string :name, null: false

      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :interaction_status, [:company_id, :name], unique: true
  end
end