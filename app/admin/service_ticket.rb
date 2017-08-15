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

end
