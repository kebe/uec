class ServiceTicket < ApplicationRecord
  belongs_to :client
  belongs_to :driver

  validates_presence_of :from_zipcode, :to_zipcode, :pickup_address, :dropoff_address, :service_time, :service_date, :client

  validate :zipcode_mileage_exists
  validate :does_not_exceed_allotted

  before_update :update_escort_hours
  mount_uploader :signature, SignatureUploader

  #validates_presence_of :approved, {message: "Exceeded hours or miles allotment. Override necessary in order to create this ticket!" }

  # before_validation(on: :create) do
  #   self.approved = true
  #   if check_accrual
  #     self.approved = true
  #   else
  #     self.approved = nil
  #   end
  # end

  def update_escort_hours

    if self.pickup_time and self.dropoff_time and (self.pickup_time != self.dropoff_time)
      self.escort_hours =  ((dropoff_time - pickup_time) / 1.hour).round(1)
    end
  end

  def zipcode_mileage_exists
    if ZipcodeMapping.get_mileage(self.from_zipcode, self.to_zipcode).nil?
      errors.add(:from_zipcode, "Couldn't find zipcode mileage") 
      errors.add(:to_zipcode, "Couldn't find zipcode mileage") 
    end
  end

  def does_not_exceed_allotted
    return unless self.client
    self.approved = nil
    if self.ticket_type ==  "miles"
      errors.add(:ticket_type, "Exceeded miles allotment. Override necessary in order to create this ticket!") unless mileage_accrual_within_limit
    elsif self.ticket_type ==  "hours"
      errors.add(:ticket_type, "Exceeded hours allotment. Override necessary in order to create this ticket!") unless hours_accrual_within_limit
    else
    end
  end
  def mileage_accrual_within_limit
  	cumulative_mileage =  self.client.total_mileage_this_month()
  	this_trips_miles = ZipcodeMapping.get_mileage(self.from_zipcode, self.to_zipcode) 

  	return false unless this_trips_miles

  	if cumulative_mileage + this_trips_miles < self.client.total_mile_allotment
  		self.mileage = this_trips_miles
  	elsif self.override == true
  		self.mileage = this_trips_miles
  	else
  	  return false
  	end
    return true
  end
  def hours_accrual_within_limit
    cumulative_hours =  self.client.total_hours_this_month()
    if cumulative_hours  >= self.client.escort_hours  && self.override != true
      return false
    end
    return true
  end
end
