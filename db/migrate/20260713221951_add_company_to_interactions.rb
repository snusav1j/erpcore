class AddCompanyToInteractions < ActiveRecord::Migration[8.0]
  def change
    add_reference :interactions, :company, foreign_key: true
  end
end
