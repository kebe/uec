class Api::V1::ServiceTicketsController < Api::V1::BaseController

  def me
  	@service_tickets = @cur_driver.service_tickets.includes(:client)
    render(json: @service_tickets.to_json( include: [:client]))
  end

  def update_service_ticket
  	@ticket = @cur_driver.service_tickets.find(params[:id])
  	if params[:type] == "pickup"
  		@ticket.pickup_time = Time.now
  	elsif params[:type] == "dropoff"
  		@ticket.dropoff_time = Time.now
  	else
  		render(json: @ticket)
  		return
  	end
  	@ticket.save
  	render(json: @ticket)
  end

  private

end
