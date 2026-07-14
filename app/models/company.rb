class Company < ApplicationRecord

  has_many :users, dependent: :restrict_with_error
  has_many :clients
  has_many :products
  has_many :orders
  has_many :interactions
  has_many :custom_fields, dependent: :destroy
  has_many :custom_field_values, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :table_settings, dependent: :destroy
  
  has_many :client_types, dependent: :destroy
  has_many :client_statuses, dependent: :destroy
  has_many :interaction_types, dependent: :destroy
  has_many :interaction_statuses, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  def inactive?
    self.active != true
  end

  def active?
    self.active == true
  end

end