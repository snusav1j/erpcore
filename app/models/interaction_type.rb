class InteractionType < ApplicationRecord
  belongs_to :company

  has_many :interactions, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }
end