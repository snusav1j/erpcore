class CreateTableSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :table_settings do |t|
      t.string :entity, null: false
      t.string :column_key, null: false
      t.integer :position, default: 0, null: false
      t.boolean :visible, default: true, null: false

      t.timestamps
    end

    add_index :table_settings, [:entity, :column_key], unique: true
  end
end