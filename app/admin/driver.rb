ActiveAdmin.register Driver do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :active, :worksheet

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :worksheet
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :active

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :worksheet
      f.input :active
    end
    f.actions
  end


end
