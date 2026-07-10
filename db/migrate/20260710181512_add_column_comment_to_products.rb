class AddColumnCommentToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :comment, :text
    remove_column :orders, :comment
    add_column :orders, :comment, :text

  end
end
