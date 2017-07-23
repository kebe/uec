class Client < ApplicationRecord
  belongs_to :route
  belongs_to :contract
  has_many :operations, -> {where(operations: { time: DateTime.now.beginning_of_day..DateTime.now.end_of_day}) }

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end
end


