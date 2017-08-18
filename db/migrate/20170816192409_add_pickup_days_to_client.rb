class AddPickupDaysToClient < ActiveRecord::Migration[5.1]
  def change
  	add_column :clients, :m_pickup, :boolean
  	add_column :clients, :t_pickup, :boolean
  	add_column :clients, :w_pickup, :boolean
  	add_column :clients, :r_pickup, :boolean
  	add_column :clients, :f_pickup, :boolean
  	add_column :clients, :m_dropoff, :boolean
  	add_column :clients, :t_dropoff, :boolean
  	add_column :clients, :w_dropoff, :boolean
  	add_column :clients, :r_dropoff, :boolean
  	add_column :clients, :f_dropoff, :boolean
  	add_column :clients, :active, :boolean

  end
end
