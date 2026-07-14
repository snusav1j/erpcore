class OrderStatus < ApplicationRecord
  belongs_to :company

  has_many :orders, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }
end