class Que < ActiveRecord::Base
  has_many :sheets
  belongs_to :category
  has_attached_file :ione, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :ione, content_type: /\Aimage\/.*\Z/
  has_attached_file :itwo, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :itwo, content_type: /\Aimage\/.*\Z/
  has_attached_file :ithree, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :ithree, content_type: /\Aimage\/.*\Z/
  has_attached_file :ifour, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :ifour, content_type: /\Aimage\/.*\Z/
  has_attached_file :iques, styles: {large: "600x600>", medium: "30", thumb: "150x150"}
  validates_attachment_content_type :iques, content_type: /\Aimage\/.*\Z/
  def display_name
    self.question
  end
end
