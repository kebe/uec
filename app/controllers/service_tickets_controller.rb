class ServiceTicketsController < InheritedResources::Base

  private

    def service_ticket_params
      params.require(:service_ticket).permit(:client_id, :driver_id, :service_date, :service_time, :pickup_address, :dropoff_address, :pickup_time, :dropoff_time)
    end
end

