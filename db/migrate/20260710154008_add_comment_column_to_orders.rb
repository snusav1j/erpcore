class AddCommentColumnToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :comment, :string
  end
end
