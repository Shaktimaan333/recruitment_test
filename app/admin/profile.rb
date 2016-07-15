ActiveAdmin.register Profile do

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
    id_column
    selectable_column
    column :name
    column :exams
    actions
  end
=begin
  show do |profile|
    attributes_table do
      row :exams do
        "#{profile.exams.join( ", " ) unless profile.exams.nil?}"
      end
    end
  end
=end

  form do |f|
    f.inputs "profile" do
      f.input :name
      f.input :exams
    end
    f.actions
  end

  # before we save, take the param[:profile][:name] parameter,
  # split and save it to our array
=begin
  before_save do |profile|
    profile.exams = params[:profile][:exams].split("[\r\n]") unless params[:profile].nil? or params[:profile][:exams].nil?
  end
=end
end
