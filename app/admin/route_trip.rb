ActiveAdmin.register RouteTrip do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :assistant, :starting_miles, :ending_miles, :lic_plate, :finish_time, :route_id, :trip_type
#
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
    column :trip_type
    column :driver
    column :assistant
    column :starting_miles
    column :ending_miles
    column :lic_plate
    column :finish_time, :sortable => :finish_time do |obj|
      obj.finish_time.try(:localtime).try(:strftime, "%I:%M %p")
    end
    column :created_at
    actions
  end
end
