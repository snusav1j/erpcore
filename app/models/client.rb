class Client < ApplicationRecord
  include ApplicationHelper
  has_many :interactions, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error

  belongs_to :company
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true
  
  validates :name, uniqueness: true
  self.custom_fields_enabled = true

  CLIENT_STATUS_NEW = 1
  CLIENT_STATUS_POTENTIAL = 2
  CLIENT_STATUS_ACTIVE = 3
  CLIENT_STATUS_INACTIVE = 4
  CLIENT_STATUS_REGULAR = 5

  CLIENT_STATUSES = [
    CLIENT_STATUS_NEW,
    CLIENT_STATUS_POTENTIAL,
    CLIENT_STATUS_ACTIVE,
    CLIENT_STATUS_INACTIVE,
    CLIENT_STATUS_REGULAR
  ]

  scope :new_clients, -> { where(status: CLIENT_STATUS_NEW) }
  scope :potential, -> { where(status: CLIENT_STATUS_POTENTIAL) }
  scope :active, -> { where(status: CLIENT_STATUS_ACTIVE) }
  scope :inactive, -> { where(status: CLIENT_STATUS_INACTIVE) }
  scope :regular, -> { where(status: CLIENT_STATUS_REGULAR) }

  def table_value(column)

    case column.to_sym
    when :manager_id
      manager&.email
    when :status
      self.status_name

    when :client_type
      self.client_type_name
    else
      super
    end

  end
  
  def client_type_name
    tm(Client, "client_type_#{self.client_type}")
  end

  def status_name
    tm(Client, "client_status_#{self.status}")
  end

end