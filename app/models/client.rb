class Client < ApplicationRecord
  belongs_to :route

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end
end
