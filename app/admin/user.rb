ActiveAdmin.register User do
  permit_params :admin, :name, :email, :mobileno, :classten, :classtwelve, :achievements, :experience, :projects, :freq, :count, :under_test, :exam_id, :redi, :password_digest
index do
  selectable_column
  column :id
  column :admin
  column :name
  column :email
  column "Mobile No.", :mobileno
  column "Class X", :classten
  column "Class XII", :classtwelve
  column "Achievements", :achievements
  column "Experience", :experience
  column "Projects", :projects
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
