class Contract < ApplicationRecord
  has_many :routes
  has_many :clients
end
