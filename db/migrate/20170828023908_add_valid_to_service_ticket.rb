class AddValidToServiceTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_tickets, :approved, :boolean
  end
end
