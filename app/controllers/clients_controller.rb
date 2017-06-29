class ClientsController < InheritedResources::Base

  private

    def client_params
      params.require(:client).permit(:first_name, :last_name, :medicaid_number, :address, :site, :disability, :route_id)
    end
end

