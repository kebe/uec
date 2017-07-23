class AddContractRefToRoutes < ActiveRecord::Migration[5.1]
  def change
    add_reference(:routes, :contract)
  end
end
