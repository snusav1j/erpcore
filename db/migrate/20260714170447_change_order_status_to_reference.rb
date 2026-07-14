class ChangeOrderStatusToReference < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :status, :string

    add_reference :orders, :order_status, foreign_key: true
  end
end