class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, foreign_key: :manager_id
  has_many :interactions, foreign_key: :manager_id

  after_initialize :set_default_role, if: :new_record?

  scope :active, -> { where.not(banned: true) }
  
  ROLES = {
    user:     0,
    worker:   1,
    director: 2,
    manager:  3
  }.freeze
  validates :role, inclusion: { in: ROLES.values }
  
  def user?
    role == ROLES[:user]
  end

  def worker?
    role == ROLES[:worker]
  end

  def director?
    role == ROLES[:director]
  end

  def manager?
    role == ROLES[:manager]
  end

  private

  def set_default_role
    self.role ||= :user
  end
end