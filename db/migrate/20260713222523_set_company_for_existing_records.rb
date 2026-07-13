class SetCompanyForExistingRecords < ActiveRecord::Migration[8.0]
  def change
    company = Company.first

    Client.update_all(company_id: company.id)
    Product.update_all(company_id: company.id)
    Order.update_all(company_id: company.id)
    Interaction.update_all(company_id: company.id)
    OrderItem.update_all(company_id: company.id)
    CustomField.update_all(company_id: company.id)
    CustomFieldValue.update_all(company_id: company.id)
    TableSetting.update_all(company_id: company.id)

    change_column_null :clients, :company_id, false
  end
end