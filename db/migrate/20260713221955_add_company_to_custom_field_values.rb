class AddCompanyToCustomFieldValues < ActiveRecord::Migration[8.0]
  def change
    add_reference :custom_field_values, :company, foreign_key: true
  end
end
