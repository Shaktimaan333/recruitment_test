ActiveAdmin.register Attempt do
  permit_params :user_id, :exam_id, :freq, :ability
index do
  selectable_column
  column :user_id
  column :exam_id
  column :ability
  column :freq
  column :start_time
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
