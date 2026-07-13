class Order < ApplicationRecord
  
  belongs_to :company
  belongs_to :client
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true

  self.custom_fields_enabled = true
end