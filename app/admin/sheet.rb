ActiveAdmin.register Sheet do

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
index do
  selectable_column
  column "Attempt", :attempt_id
  column :answer
  column :correct
  column "Question", :ques_id
  column :updated
  column "Difficulty", :ques_id do |id|
    Que.find(id).diff
  end
  actions
end


end
