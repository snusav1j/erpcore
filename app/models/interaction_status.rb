class InteractionStatus < ApplicationRecord

  belongs_to :company

  has_many :interactions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }

end