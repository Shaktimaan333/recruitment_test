class Category < ActiveRecord::Base
  has_many :ques
  belongs_to :exam
  def display_name
    self.name
  end
end
