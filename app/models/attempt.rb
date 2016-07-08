class Attempt < ActiveRecord::Base
  has_many :sheets
  belongs_to :user
  belongs_to :exam
  def display_name
    if self.user_id!=nil && self.freq!=nil
      "#{User.find_by(id: self.user_id).name}, #{self.freq}"
    end
  end
end
