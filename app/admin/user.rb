ActiveAdmin.register User do
permit_params :freq, :under_test, :count, :redi, :exam_id, :attempt_id, :name, :email, :projects, :achievements, :experience, :projects, :classten, :classtwelve, :admin
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
