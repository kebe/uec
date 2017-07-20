class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.string :op_type
      t.timestamp :time
      t.references :client, foreign_key: true
      t.references :driver, foreign_key: true
      t.string :status
      t.string :helper
      t.boolean :wheelchair

      t.timestamps
    end
  end
end
