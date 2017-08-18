class Route < ApplicationRecord
  has_many :clients
  has_many :todays_pickup_clients, -> { todays('pickup') }, class_name: "Client"
  has_many :todays_dropoff_clients, -> { todays('dropoff') }, class_name: "Client"
  has_many :route_trips
  has_many :todays_leave_route_trips, -> { where(trip_type: "leave", created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }, class_name: "RouteTrip"
  has_many :todays_return_route_trips, -> { where(trip_type: "return", created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }, class_name: "RouteTrip"
  belongs_to :contract
  belongs_to :driver
end
	