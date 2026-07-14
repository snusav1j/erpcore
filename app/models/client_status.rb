class ClientStatus < ApplicationRecord

  belongs_to :company

  has_many :clients, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }

end