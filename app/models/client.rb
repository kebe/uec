class Client < ApplicationRecord
  belongs_to :route
  belongs_to :contract
  has_many :operations, -> {where(operations: { time: DateTime.now.beginning_of_day..DateTime.now.end_of_day}) }
  has_many :service_tickets

  enum positions: [ :atb, :ftb]
  enum type: [ :goodwill, :franklin_county, :senior_option]

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end

  def total_mileage_this_month
  	self.service_tickets.where(service_date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:mileage)
  end

  def total_mile_allotment
  	self.medical_miles + self.non_medical_miles
  end
end
