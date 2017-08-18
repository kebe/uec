class CreateRouteTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :route_trips do |t|
      t.references :route, foreign_key: true
      t.string :trip_type
      t.string :assistant
      t.decimal :starting_miles
      t.decimal :ending_miles
      t.string :lic_plate
      t.time :finish_time
      t.timestamps
    end
  end
end
