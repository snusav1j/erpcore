class AddColumnPriceToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :price, :float
    add_column :products, :in_stock, :boolean

    remove_column :products, :status
  end
end
