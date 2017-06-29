class RoutesController < InheritedResources::Base

  def today_schedule
    @route = Route.find(params[:id])
  end

  private

    def route_params
      params.require(:route).permit(:name)
    end
end

