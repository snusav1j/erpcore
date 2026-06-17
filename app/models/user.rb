class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, foreign_key: :manager_id
  has_many :interactions, foreign_key: :manager_id

  after_initialize :set_default_role, if: :new_record?

  scope :active, -> { where.not(banned: true) }

  ROLES = %w[user worker director manager].freeze

  validates :role, inclusion: { in: ROLES }

  def user?
    role == 'user'
  end

  def worker?
    role == 'worker'
  end

  def director?
    role == 'director'
  end

  def manager?
    role == 'manager'
  end

  private

  def set_default_role
    self.role ||= 'user'
  end
end