class RemoveColumnStatusIdFromClients < ActiveRecord::Migration[8.0]
  def change
    remove_column :clients, :status_id  
  end
end
