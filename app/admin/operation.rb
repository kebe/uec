ActiveAdmin.register Operation do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :type, :time, :client_id, :driver_id, :status, :helper, :wheelchair
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	filter :route
    filter :contract
    filter :driver
 	filter :client
    filter :time
	filter :op_type 
    filter :status
    filter :helper
    filter :wheelchair
    

  index do
    selectable_column
    id_column
    column :op_type
    column :time
    column :client
    column :driver
    column :status
    column :helper
    column :wheelchair
    column :route
    column :contract
    actions
  end

end
