class CreateDropoffs < ActiveRecord::Migration[5.1]
  def change
    create_table :dropoffs do |t|
      t.string :status
      t.string :day
      t.date :dropoff_date
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
