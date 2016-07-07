class HeadshotPhoto < ActiveRecord::Base
  attr_accessor :description, :image_content_type, :image_file_name, :image_file_size, :image_updated_at

  belongs_to :capturable, :polymorphic => true


  has_attached_file :tryimage, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :tryimage, content_type: /\Aimage\/.*\Z/
  #has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
