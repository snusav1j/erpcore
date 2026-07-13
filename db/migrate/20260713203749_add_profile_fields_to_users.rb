class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :banned, :boolean, default: false, null: false

    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string

    add_column :users, :birthday, :date

    add_column :users, :phone, :string

    add_column :users, :telegram, :string
    add_column :users, :telegram_chat_id, :bigint

    add_index :users, :phone
    add_index :users, :telegram
    add_index :users, :telegram_chat_id
    add_index :users, :banned
  end
end