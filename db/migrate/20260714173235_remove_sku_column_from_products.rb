class RemoveSkuColumnFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :sku
  end
end
