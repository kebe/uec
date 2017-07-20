class OperationsController < InheritedResources::Base

  private

    def operation_params
      params.require(:operation).permit(:type, :time, :client_id, :driver_id, :status, :helper, :wheelchair)
    end
end

