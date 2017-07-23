class AddContractRefToClients < ActiveRecord::Migration[5.1]
  def change
    add_reference(:clients, :contract)
  end
end
