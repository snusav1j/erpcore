class Interaction < ApplicationRecord
  belongs_to :client
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id, optional: true
end