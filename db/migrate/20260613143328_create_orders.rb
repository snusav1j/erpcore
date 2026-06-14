class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true

      t.string :status

      t.float :amount
      t.float :expense
      t.float :profit

      t.text :comment

      t.datetime :closed_at

      t.timestamps
    end
  end
end