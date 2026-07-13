class Product < ApplicationRecord

  belongs_to :company
  belongs_to :manager, class_name: 'User', optional: true
  has_many :order_items, dependent: :restrict_with_error
  validates :name, presence: true

  self.custom_fields_enabled = true
end