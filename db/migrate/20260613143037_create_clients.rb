class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :comment

      t.timestamps
    end

    add_index :clients, :phone
  end
end