class Driver < ApplicationRecord
  has_many :routes
  has_many :operations
  has_many :service_tickets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  mount_uploader :worksheet, WorksheetUploader

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end
end
