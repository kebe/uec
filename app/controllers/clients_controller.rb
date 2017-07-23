class ClientsController < InheritedResources::Base

  private

    def client_params
      params.require(:client).permit(:first_name, :last_name, :goodwill_account_type, :medicaid_number, :address, :site, :disability, :route_id, :contract_id)
    end
end

