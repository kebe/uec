class AddFieldsToServiceTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_tickets, :from_zipcode, :string
  	add_column :service_tickets, :to_zipcode, :string
  	add_column :service_tickets, :override, :boolean
  end
end
