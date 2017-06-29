class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :medicaid_number
      t.string :address
      t.string :site
      t.boolean :disability
      t.references :route, foreign_key: true

      t.timestamps
    end
  end
end
