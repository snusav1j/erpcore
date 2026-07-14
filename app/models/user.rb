class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clients, foreign_key: :manager_id
  has_many :orders, foreign_key: :manager_id
  has_many :interactions, foreign_key: :manager_id

  has_one :user_setting, dependent: :destroy
  
  belongs_to :company, optional: true
  
  after_initialize :set_default_role, if: :new_record?

  scope :active, -> { where.not(banned: true) }

  ROLES = %w[ceo director manager].freeze

  validates :role, inclusion: { in: ROLES }

  def roles_for_edit
    if self.ceo?
      %w[ceo director manager]
    elsif self.director?
      %w[director manager]
    end
  end

  def has_admin_rights?
    self.ceo? || self.director?
  end

  def can_edit_company_for?(user)
    return true if self.ceo?
  end

  def can_edit_role_for?(user)
    return true if self.ceo?
    return false if self.manager?

    if self.director?
      return user.manager?
    end

    false
  end

  def can_interact_with_client?(client)
    (self.id == client.manager_id) || self.has_admin_rights?
  end

  def banned?
    self.banned == true
  end

  def ceo?
    self.role == 'ceo'
  end

  def director?
    self.role == 'director'
  end

  def manager?
    self.role == 'manager'
  end

  def set_sidebar_state(state)
    (self.user_setting || self.create_user_setting).update(hide_sidebar: state)
  end

  def get_sidebar_state
    self.user_setting&.hide_sidebar
  end

  def set_column_visibility_block_state(state)
    (self.user_setting || self.create_user_setting).update(column_visibility_block_state: state)
  end

  def get_column_visibility_block_state
    self.user_setting&.column_visibility_block_state
  end

  def set_custom_fields_block_state(state)
    (self.user_setting || self.create_user_setting).update(custom_fields_block_state: state)
  end

  def get_custom_fields_block_state
    self.user_setting&.custom_fields_block_state
  end

  def fullname
    if self.last_name.present? && self.first_name.present? && self.middle_name.present?
      "#{self.last_name} #{self.first_name} #{self.middle_name}"
    elsif self.last_name.present? && self.first_name.present?
      "#{self.last_name} #{self.first_name}"
    else
      self.email
    end
  end

  private

  def set_default_role
    self.role ||= 'user'
  end
end