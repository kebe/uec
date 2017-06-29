class DropoffsController < InheritedResources::Base

  private

    def dropoff_params
      params.require(:dropoff).permit(:status, :day, :dropoff_date, :client_id)
    end
end

