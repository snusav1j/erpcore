class Interaction < ApplicationRecord
  include ApplicationHelper
  
  belongs_to :company
  belongs_to :client
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true
  belongs_to :interaction_type
  belongs_to :interaction_status
  
  self.custom_fields_enabled = true

  INTERACTION_TYPE_CALL = 1
  INTERACTION_TYPE_MESSAGE = 2
  INTERACTION_TYPE_MEETING = 3
  INTERACTION_TYPES = [INTERACTION_TYPE_CALL, INTERACTION_TYPE_MESSAGE, INTERACTION_TYPE_MEETING]

  def interaction_type_name
    tm(Interaction, "interaction_type_#{self.interaction_type}")
  end

  def table_value(column)

    case column.to_sym
    when :manager_id
      manager&.email
    when :interaction_status_id
      self.interaction_status&.name
    when :interaction_type_id
      self.interaction_type&.name
    when :company_id
      self.company&.name
    else
      super
    end

  end

end