class RemoveUnusedFieldsFromCoreTables < ActiveRecord::Migration[8.0]
  def change

    remove_column :clients, :source, :string
    remove_column :clients, :country, :string
    remove_column :clients, :city, :string
    remove_column :clients, :inn, :string
    remove_column :clients, :ogrn, :string


    remove_column :orders, :amount, :float
    remove_column :orders, :expense, :float
    remove_column :orders, :profit, :float
    remove_column :orders, :comment, :text

  end
end