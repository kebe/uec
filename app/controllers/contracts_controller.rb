class ContractsController < InheritedResources::Base

  private

    def contract_params
      params.require(:contract).permit(:name, :address, :contact_name, :phone_number, :active)
    end
end

