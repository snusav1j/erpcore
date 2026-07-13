class AddCompanyToCustomFields < ActiveRecord::Migration[8.0]
  def change
    add_reference :custom_fields, :company, foreign_key: true
  end
end
