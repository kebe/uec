class CreatePickups < ActiveRecord::Migration[5.1]
  def change
    create_table :pickups do |t|
      t.string :status
      t.string :day
      t.date :pickup_date
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
