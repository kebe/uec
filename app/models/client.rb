class Client < ApplicationRecord
  belongs_to :route
  belongs_to :contract
  has_many :operations, -> {where(operations: { time: DateTime.now.beginning_of_day..DateTime.now.end_of_day}) }
  has_many :service_tickets

  validates_inclusion_of :goodwill_account_type, :in => %w( atb ftb uec ), :message => "goodwill account type value is not valid"
  validates_inclusion_of :site, :in => %w( DAS VR RT WG HW INDV SAGE YAS YASEH WCS ), :message => "site value is not valid"
  validates_inclusion_of :client_type, :in => %w( goodwill franklin_county senior_option ), :message => "client type value is not valid"

  scope :todays, lambda { |type|
    if type == 'pickup'
      field = self.get_pickup_field
    elsif type == 'dropoff'
      field = self.get_dropoff_field
    end
    where(field.to_sym => true)
  }

  def full_name
    (last_name || "") + ", " + (first_name || "")
  end

  def total_mileage_this_month
  	self.service_tickets.where(service_date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:mileage)
  end

  def total_mile_allotment
  	self.medical_miles + self.non_medical_miles
  end

  def self.get_pickup_field()
      day = Time.now.wday
      case day
      when 1
        return 'm_pickup'
      when 2
        return 't_pickup'
      when 3
        return 'w_pickup'
      when 4
        return 'r_pickup'
      when 5
        return 'f_pickup'
      else 
        return 'm_pickup'
      end   
  end

  def self.get_dropoff_field()
      day = Time.now.wday
      case day
      when 1
        return 'm_dropoff'
      when 2
        return 't_dropoff'
      when 3
        return 'w_dropoff'
      when 4
        return 'r_dropoff'
      when 5
        return 'f_dropoff'
      else 
        return 'm_dropoff'
      end   
  end
  
  private
    
end
