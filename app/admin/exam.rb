ActiveAdmin.register Exam do
  permit_params :topic, :no,:category_name
  index do
    selectable_column
    column :id
    column :topic
    #column :category_name
    actions
  end
  form multipart: true do |f|
    f.inputs "Details" do
      f.input :topic
      #f.input :category_name
      f.input :no, :input_html => { :value => 0 }, as: :hidden
    end
    f.actions
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
