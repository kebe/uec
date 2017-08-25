class AddSignatureToServiceTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :service_tickets, :signature, :string
  end
end
