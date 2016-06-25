ActiveAdmin.register Que do
  permit_params :question, :one, :two, :three, :four, :correct, :diff, :no_attempt, :correct_attempt, :wrong_attempt, :category_id, :diff, :ione, :itwo, :ithree, :ifour, :iques
  form multipart: true do |f|
    f.inputs "Details for New Question" do
      f.input :category #, as: :select, collection: Category.select(:name).uniq
      f.input :question
      f.input :one, label: "Option 1"
      f.input :two, label: "Option 2"
      f.input :three, label: "Option 3"
      f.input :four, label: "Option 4"
      f.input :correct, as: :select, collection: (1..4).map { |i| i }, label: "Correct Options"
      f.input :diff, as: :select, collection: (0..5).map { |i| i }, label: "Difficulty Level" 
      #f.select(:diff, options_for_select([[1,1], [2,2], [3,3], [4,4], [5,5]]))
      f.input :iques, required: false, label: "Image Question"
      f.input :ione, required: false, label: "Image Option-1"
      f.input :itwo, required: false, label: "Image Option-2"
      f.input :ithree, required: false, label: "Image Option-3"
      f.input :ifour, required: false, label: "Image Option-4"
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
