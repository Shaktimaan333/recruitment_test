ActiveAdmin.register Category do
  permit_params :name
  form multipart: true do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.actions
  end
  index do
    selectable_column
    column :name
    actions
  end



  

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
