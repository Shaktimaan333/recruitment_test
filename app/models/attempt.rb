class Attempt < ActiveRecord::Base
  has_many :sheets
  belongs_to :user
  belongs_to :exam
  def display_name
    if User.find_by(id: self.user_id).name!=nil && self.freq!=nil
      "#{User.find_by(id: self.user_id).name}, #{self.freq}"
    end
  end
end
