class AddColumnStatusToClients < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :status, :string, default: 'new'
    add_column :clients, :source, :string
  end
end
