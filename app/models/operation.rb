class Operation < ApplicationRecord
  belongs_to :client
  belongs_to :driver

  before_create do
    self.time = DateTime.now unless self.time
  end
end
