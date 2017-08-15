class CreateZipcodeMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :zipcode_mappings do |t|
      t.string :start_zip
      t.string :end_zip
      t.string :mileage

      t.timestamps
    end
  end
end
