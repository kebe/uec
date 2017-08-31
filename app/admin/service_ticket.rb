ActiveAdmin.register ServiceTicket do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :client_id, :driver_id, :service_date, :service_time, :pickup_address, :dropoff_address, :pickup_time, :dropoff_time, 
                :override, :to_zipcode, :from_zipcode, :ticket_type, :escort_hours
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
    column :ticket_type
    column :client
    column :driver
    column :service_date
    column :service_time, :sortable => :service_time do |obj|
      obj.service_time.try(:localtime).try(:strftime, "%I:%M %p")
    end
    column :pickup_address
    column "From Zip", :from_zipcode
    column :dropoff_address
    column "To Zip", :to_zipcode
    column :pickup_time, :sortable => :pickup_time do |obj|
      obj.pickup_time.try(:localtime).try(:strftime, "%I:%M %p")
    end
    column :dropoff_time, :sortable => :dropoff_time do |obj|
      obj.dropoff_time.try(:localtime).try(:strftime, "%I:%M %p")
    end
    column :override
    actions
  end

    form do |f|
    f.inputs "Service Tickets" do
      f.input :ticket_type, :as => :select, :collection => %w( miles hours )
      f.input :client
      f.input :driver
      f.input :service_date, as: :datepicker,
                      datepicker_options: {
                        min_date: Date.today                      }
      f.input :service_time
      f.input :pickup_address
      f.input :from_zipcode
      f.input :dropoff_address
      f.input :to_zipcode
      f.input :pickup_time
      f.input :dropoff_time
      f.input :override
    end
    f.actions
  end

  ActiveAdmin.register ServiceTicket do
    show do
      attributes_table do
        row :ticket_type
        row :client
        row :driver
        row :service_date                    
        row :service_time do |service_ticket|
          service_ticket.service_time.try(:localtime).try(:strftime, "%I:%M %p")
        end
        row :pickup_address
        row :from_zipcode
        row :dropoff_address
        row :to_zipcode
        row :pickup_time do |service_ticket|
          service_ticket.pickup_time.try(:localtime).try(:strftime, "%I:%M %p")
        end
        row :dropoff_time do |service_ticket|
          service_ticket.dropoff_time.try(:localtime).try(:strftime, "%I:%M %p")
        end
        row :override
        row :signature do |service_ticket|
          image_tag service_ticket.signature.url
        end
      end
      active_admin_comments
    end
  end
end
