class RouteTrip < ApplicationRecord
	belongs_to :route
	validates_inclusion_of :trip_type, :in => %w( leave return  ), :message => "trip type value is not valid"
end
