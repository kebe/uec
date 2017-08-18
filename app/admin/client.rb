ActiveAdmin.register Client do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :first_name, :last_name, :goodwill_account_type, :medicaid_number, :address, :site, :disability, :route_id, :contract_id, :client_type, :medical_miles, 
              :non_medical_miles, :escort_hours, :active, :m_pickup, :t_pickup, :w_pickup, :r_pickup, :f_pickup, :m_dropoff, :t_dropoff, :w_dropoff, :r_dropoff, :f_dropoff
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
    column :first_name
    column :last_name
    column "Goodwill Type", :goodwill_account_type
    column "Medicaid #", :medicaid_number
    column :address
    column :disability
    column :route
    column :contract
    column :client_type
    column "Med miles", :medical_miles
    column "Non-Med miles",:non_medical_miles
    column "Esc hrs", :escort_hours
    actions
  end

  form do |f|
    f.inputs "Clients" do
      f.input :client_type, :label => 'Account Type', :as => :select, :collection =>  %w( goodwill franklin_county senior_option )
      f.input :first_name
      f.input :last_name
      f.input :goodwill_account_type, :label => 'GoodWill Type', :as => :select, :collection => %w( atb ftb uec )
      f.input :medicaid_number
      f.input :address
      f.input :site , :label => 'Site', :as => :select, :collection =>  %w( DAS VR RT WG HW INDV SAGE YAS YASEH WCS )
      f.input :disability
      f.input :route_id, :label => 'Route', :as => :select, :collection => Route.all.map{|r| ["#{r.name}", r.id]}
      f.input :contract_id, :label => 'Contract', :as => :select, :collection => Contract.all.map{|c| ["#{c.name}", c.id]}
      f.input :medical_miles
      f.input :non_medical_miles
      f.input :escort_hours
      f.input :m_pickup
      f.input :t_pickup
      f.input :w_pickup
      f.input :r_pickup
      f.input :f_pickup
      f.input :m_dropoff
      f.input :t_dropoff
      f.input :w_dropoff
      f.input :r_dropoff
      f.input :f_dropoff
      f.input :active
    end
    f.actions
  end

end
