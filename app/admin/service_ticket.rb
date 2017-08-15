ActiveAdmin.register ServiceTicket do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :client_id, :driver_id, :service_date, :service_time, :pickup_address, :dropoff_address, :pickup_time, :dropoff_time, :override, :to_zipcode, :from_zipcode
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    selectable_column
    id_column
    column :client
    column :driver
    column :service_date
    column :service_time
    column :pickup_address
    column :from_zipcode
    column :dropoff_address
    column :to_zipcode
    column :pickup_time
    column :dropoff_time
    column :override
    actions
  end
end
