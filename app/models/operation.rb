class Operation < ApplicationRecord
  belongs_to :client
  belongs_to :driver
  has_one :route, through: :client 
  has_one :contract, through: :client 

  before_create do
    self.time = DateTime.now unless self.time
  end
end
