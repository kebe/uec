class FixServiceTicketTimeTypes < ActiveRecord::Migration[5.1]
  def change
  	remove_column :service_tickets, :pickup_time, :string
  	remove_column :service_tickets, :dropoff_time, :string
  	add_column :service_tickets, :pickup_time, :time
  	add_column :service_tickets, :dropoff_time, :time
  end
end
