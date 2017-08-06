class RoutesController < InheritedResources::Base

  def today_schedule
    #@route = current_driver.routes.where(:routes => {:id => params[:id]}).first
  end

  def app

  end
  
  def default_route
    @route = current_driver.routes.first
    route_id = @route.try(:id) || 1
    redirect_to action: "today_schedule", id: route_id
  end
  private

    def route_params
      params.require(:route).permit(:name, :contract_id, :driver_id)
    end
end

