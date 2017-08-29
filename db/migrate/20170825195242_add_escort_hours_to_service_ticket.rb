class AddEscortHoursToServiceTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_tickets, :escort_hours, :decimal
  	add_column :service_tickets, :ticket_type, :string
  end
end
