class PickupsController < InheritedResources::Base

  private

    def pickup_params
      params.require(:pickup).permit(:status, :day, :pickup_date, :client_id)
    end
end

