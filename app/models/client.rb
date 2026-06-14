class Client < ApplicationRecord
  has_many :interactions, dependent: :destroy
  has_many :orders, dependent: :destroy
end