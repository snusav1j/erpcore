class ChangeClientStatusToReference < ActiveRecord::Migration[8.0]
  def change
    add_reference :clients, :client_status, foreign_key: true unless column_exists?(:clients, :client_status_id)
  end
end