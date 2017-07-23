class AddGoodWillAccountTypeToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :goodwill_account_type, :string
  end
end
