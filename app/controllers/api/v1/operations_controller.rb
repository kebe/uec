class Api::V1::OperationsController < Api::V1::BaseController
  def create_operation
    @operation = Operation.create!(operation_params)
    render(json: @operation, status: :created)
  end

  def remove_operation
    @operation = @cur_driver.operations.find(params[:id])
    @result = @operation.destroy
    render(json: @result, status: :created)
  end

  def todays_operations
    @operations = @cur_driver.operations.where(time: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
    render(json: @operations)
  end

  private

    def operation_params
      # whitelist params
      params.permit(:op_type, :time, :client_id, :driver_id, :status, :helper, :wheelchair)
    end

    def set_operation
      @todo = Todo.find(params[:id])
    end
end
