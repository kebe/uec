class AddMileageFieldToServiceTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_tickets, :mileage, :decimal
  end
end
