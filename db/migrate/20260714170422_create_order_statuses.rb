class CreateOrderStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :order_statuses do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.string :color

      t.timestamps
    end

    add_index :order_statuses, [:company_id, :name], unique: true
  end
end