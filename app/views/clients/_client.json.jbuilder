json.extract! client, :id, :first_name, :last_name, :medicaid_number, :address, :site, :disability, :route_id, :created_at, :updated_at
json.url client_url(client, format: :json)
