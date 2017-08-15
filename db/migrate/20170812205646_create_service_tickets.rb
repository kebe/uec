class CreateServiceTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :service_tickets do |t|
      t.references :client, foreign_key: true
      t.references :driver, foreign_key: true
      t.date :service_date
      t.time :service_time
      t.string :pickup_address
      t.string :dropoff_address
      t.string :pickup_time
      t.string :dropoff_time

      t.timestamps
    end
  end
end
