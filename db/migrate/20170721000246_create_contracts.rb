class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :phone_number
      t.boolean :active

      t.timestamps
    end
  end
end
