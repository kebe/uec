class Api::V1::RoutesController < Api::V1::BaseController
  # def index
  #   route = Route.includes( :driver, clients: [:operations]).first
  #   render(json: route.to_json( include: [:driver, :clients => {include: [:operations]}] ))
  # end
  def show
    route = @cur_driver.routes.includes( :todays_leave_route_trips, :todays_return_route_trips, driver: [:routes], todays_pickup_clients: [:operations], todays_dropoff_clients: [:operations]).where(id: params[:id]).first
    render(json: route.to_json( include: [ :todays_leave_route_trips, :todays_return_route_trips, {:todays_pickup_clients => {include: [:operations]}}, {:todays_dropoff_clients => {include: [:operations]}}, {:driver => {include: [:routes]}}] ))
  end

  def finish_leave_route
  	@route = @cur_driver.routes.find(params[:id])
  	@route_trip = @route.route_trips.build(finished_route_params)
 	@route_trip.trip_type = "leave"
 	@route_trip.finish_time = Time.now
 	@route_trip.save

  	# @route.todays_pickup_clients.each do |client|
  	# 	@route.update_params(route_update_params)
  	# end
  	render(json: @route_trip)
  end

  def finish_return_route
  	@route = @cur_driver.routes.find(params[:id])
  	@route_trip = @route.route_trips.build(finished_route_params)
 	@route_trip.trip_type = "return"
 	@route_trip.finish_time = Time.now
 	@route_trip.save
 	
  	# @route.todays_pickup_clients.each do |client|
  	# 	@route.update_params(route_update_params)
  	# end
  	render(json: @route_trip)
  end

  private

    def finished_route_params
      params.permit(:assistant, :starting_miles, :ending_miles, :lic_plate)
    end
end



