ActiveAdmin.register HeadshotPhoto do

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
  column "Webcam Photos" do |headshot_photo|
      link_to(image_tag(headshot_photo.tryimage.url(:thumb), :height => '100'), admin_headshot_photo_path(headshot_photo))
  end
  actions
end

end
