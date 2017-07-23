ActiveAdmin.register Client do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :first_name, :last_name, :goodwill_account_type, :medicaid_number, :address, :site, :disability, :route_id, :contract_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    f.inputs "Clients" do
      f.input :first_name
      f.input :last_name
      f.input :goodwill_account_type, :label => 'GoodWill Type', :as => :select, :collection => ["atb", "ftc", "uec"]
      f.input :medicaid_number
      f.input :address
      f.input :site
      f.input :disability
      f.input :route_id, :label => 'Route', :as => :select, :collection => Route.all.map{|r| ["#{r.name}", r.id]}
      f.input :contract_id, :label => 'Contract', :as => :select, :collection => Contract.all.map{|c| ["#{c.name}", c.id]}
    end
    f.actions
  end

end
