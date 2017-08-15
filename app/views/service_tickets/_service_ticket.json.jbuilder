json.extract! service_ticket, :id, :client_id, :driver_id, :service_date, :service_time, :pickup_address, :dropoff_address, :pickup_time, :dropoff_time, :created_at, :updated_at
json.url service_ticket_url(service_ticket, format: :json)
