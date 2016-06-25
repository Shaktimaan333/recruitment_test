ActiveAdmin.register Que do
  permit_params :question, :one, :two, :three, :four, :correct, :diff, :no_attempt, :correct_attempt, :wrong_attempt, :category_id, :diff, :ione, :itwo, :ithree, :ifour, :iques
  form multipart: true do |f|
    f.inputs "Details" do
      f.input :category_id
      f.input :question
      f.input :one
      f.input :two
      f.input :three
      f.input :four
      f.input :correct
      f.input :diff
      f.input :ione, required: false
      f.input :itwo, required: false
      f.input :ithree, required: false
      f.input :ifour, required: false
      f.input :iques, required: false
      f.input :no_attempt, :input_html => { :value => 0 }, as: :hidden
      f.input :correct_attempt, :input_html => { :value => 0 }, as: :hidden
      f.input :wrong_attempt, :input_html => { :value => 0 }, as: :hidden
    end
    f.actions
  end
  index do
    selectable_column
    column :category_id
    column :question
    column :one
    column :two
    column :three
    column :four
    column :correct
    column :diff
    column "Image Question" do |que|
      link_to(image_tag(que.iques.url(:thumb), :height => '100'), admin_que_path(que))
    end
    column "Op-1(Image)" do |que|
      link_to(image_tag(que.ione.url(:thumb), :height => '100'), admin_que_path(que))
    end
    column "Op-2(Image)" do |que|
      link_to(image_tag(que.itwo.url(:thumb), :height => '100'), admin_que_path(que))
    end
    column "Op-3(Image)" do |que|
      link_to(image_tag(que.ithree.url(:thumb), :height => '100'), admin_que_path(que))
    end
    column "Op-4(Image)" do |que|
      link_to(image_tag(que.ifour.url(:thumb), :height => '100'), admin_que_path(que))
    end
    #column "No. of Attempts", :no_attempt
    #column "Correct Attempts", :correct_attempt
    #column "Wrong Attempts", :wrong_attempt
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
