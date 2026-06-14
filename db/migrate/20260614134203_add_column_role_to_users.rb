class AddColumnRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string
    add_column :orders, :manager_id, :integer
    add_column :interactions, :manager_id, :integer
    
    add_index :users, :role
    add_index :orders, :manager_id
    add_index :interactions, :manager_id
  end
end
