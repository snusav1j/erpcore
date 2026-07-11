class Client < ApplicationRecord
  include ApplicationHelper
  include TranslateHelper
  has_many :interactions, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error

  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true

  self.custom_fields_enabled = true

  CLIENT_STATUS_NEW = 1
  CLIENT_STATUS_POTENTIAL = 2
  CLIENT_STATUS_ACTIVE = 3
  CLIENT_STATUS_INACTIVE = 4
  CLIENT_STATUS_REGULAR = 5

  CLIENT_TYPE_DISTRIBUTOR = 1
  CLIENT_TYPE_WHOLESALER = 2
  CLIENT_TYPE_RETAIL_STORE = 3
  CLIENT_TYPE_RETAIL_CHAIN = 4
  CLIENT_TYPE_CAFE = 5
  CLIENT_TYPE_RESTAURANT = 6
  CLIENT_TYPE_BAKERY = 7
  CLIENT_TYPE_CONFECTIONERY = 8
  CLIENT_TYPE_FOOD_PRODUCTION = 9
  CLIENT_TYPE_CATERING = 10
  CLIENT_TYPE_HOTEL = 11
  CLIENT_TYPE_FARMER = 12
  CLIENT_TYPE_GOVERNMENT = 13
  CLIENT_TYPE_MARKETPLACE = 14
  CLIENT_TYPE_OTHER = 15

  CLIENT_TYPES = [
    CLIENT_TYPE_DISTRIBUTOR,
    CLIENT_TYPE_WHOLESALER,
    CLIENT_TYPE_RETAIL_STORE,
    CLIENT_TYPE_RETAIL_CHAIN,
    CLIENT_TYPE_CAFE,
    CLIENT_TYPE_RESTAURANT,
    CLIENT_TYPE_BAKERY,
    CLIENT_TYPE_CONFECTIONERY,
    CLIENT_TYPE_FOOD_PRODUCTION,
    CLIENT_TYPE_CATERING,
    CLIENT_TYPE_HOTEL,
    CLIENT_TYPE_FARMER,
    CLIENT_TYPE_GOVERNMENT,
    CLIENT_TYPE_MARKETPLACE,
    CLIENT_TYPE_OTHER
  ]

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