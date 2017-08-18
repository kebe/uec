class RectifyEscortHours < ActiveRecord::Migration[5.1]
  def change
  	remove_column :clients, :medical_escort_hours, :decimal
  	remove_column :clients, :non_medical_escort_hours, :decimal
  	add_column :clients, :escort_hours, :decimal
  end
end
