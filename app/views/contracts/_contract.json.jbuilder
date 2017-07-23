json.extract! contract, :id, :name, :address, :contact_name, :phone_number, :active, :created_at, :updated_at
json.url contract_url(contract, format: :json)
