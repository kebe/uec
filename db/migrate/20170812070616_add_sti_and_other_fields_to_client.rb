class AddStiAndOtherFieldsToClient < ActiveRecord::Migration[5.1]
  def change
  	add_column :clients, :client_type, :string
  end
end
