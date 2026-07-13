class AddCompanyToTableSettings < ActiveRecord::Migration[8.0]
  def change
    add_reference :table_settings, :company, foreign_key: true
  end
end
