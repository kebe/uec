class ServiceTicket < ApplicationRecord
  belongs_to :client
  belongs_to :driver

  before_save :check_mileage_accrual

  def check_mileage_accrual
  	cumulative_mileage =  self.client.total_mileage_this_month()
  	this_trips_miles = ZipcodeMapping.get_mileage(self.from_zipcode, self.to_zipcode) 

  	throw(:abort) unless this_trips_miles

  	if cumulative_mileage + this_trips_miles < self.client.total_mile_allotment
  		self.mileage = this_trips_miles
  	elsif self.override == true
  		self.mileage = this_trips_miles
  	else
  	  throw(:abort)
  	end

  end
end
