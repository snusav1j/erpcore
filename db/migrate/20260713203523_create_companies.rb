class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.boolean :active, null: false, default: true
      t.datetime :paid_until

      t.references :manager, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :companies, :slug, unique: true
    add_index :companies, :active

    add_reference :users, :company, foreign_key: true
  end
end