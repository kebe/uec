class AddWorksheetToDriver < ActiveRecord::Migration[5.1]
  def change
  	add_column :drivers, :worksheet, :string
  end
end
