class AddMoreFieldsToClient < ActiveRecord::Migration[5.1]
  def change
  	add_column :clients, :medical_miles, :decimal
  	add_column :clients, :non_medical_miles, :decimal
  	add_column :clients, :medical_escort_hours, :decimal
  	add_column :clients, :non_medical_escort_hours, :decimal
  end
end
