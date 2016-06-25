class Category < ActiveRecord::Base
  has_many :ques
  def display_name
    self.name
  end
end
