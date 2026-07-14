class Product < ApplicationRecord

  belongs_to :company
  belongs_to :manager, class_name: 'User', optional: true
  has_many :order_items, dependent: :restrict_with_error
  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }

  self.custom_fields_enabled = true

  def table_value(column)
    case column.to_sym
    when :client_id
      self.client&.name
    when :order_status_id
      self.order_status&.name
    when :company_id
      self.company&.name
    when :closed_at
      self.closed_at
    when :manager_id
      self.manager&.fullname
    else
      super
    end
  end
end