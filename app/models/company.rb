class Company < ApplicationRecord

  has_many :users, dependent: :restrict_with_error
  has_many :clients
  has_many :products
  has_many :orders
  has_many :interactions
  has_many :custom_fields
  has_many :custom_field_values
  has_many :order_items
  has_many :table_settings
  
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  def inactive?
    self.active != true
  end

  def active?
    self.active == true
  end

end