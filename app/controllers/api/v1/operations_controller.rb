class Api::V1::OperationsController < Api::V1::BaseController
  def create_operation
    @operation = Operation.create!(operation_params)
    render(json: @operation, status: :created)
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
