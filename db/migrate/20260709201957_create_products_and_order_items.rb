class CreateProductsAndOrderItems < ActiveRecord::Migration[8.0]
  def change

    add_column :orders,
      :final_price,
      :decimal,
      precision: 12,
      scale: 2


    create_table :products do |t|

      t.string :name, null: false

      t.string :sku

      t.references :manager

      t.integer :status, default: 1

      t.timestamps

    end


    create_table :order_items do |t|

      t.references :order,
        null: false,
        foreign_key: true


      t.references :product,
        null: false,
        foreign_key: true


      t.decimal :price,
        precision: 12,
        scale: 2


      t.integer :quantity,
        default: 1


      t.decimal :total,
        precision: 12,
        scale: 2


      t.timestamps

    end

  end
end