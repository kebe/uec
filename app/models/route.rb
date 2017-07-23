class Route < ApplicationRecord
  has_many :clients
  belongs_to :contract
  belongs_to :driver
end
