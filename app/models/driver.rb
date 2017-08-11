class Driver < ApplicationRecord
  has_many :routes
  has_many :operations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end
end
