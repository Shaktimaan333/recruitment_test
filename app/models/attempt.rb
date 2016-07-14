class Attempt < ActiveRecord::Base
  has_many :sheets
  belongs_to :user
  belongs_to :exam
  belongs_to :profile
  def display_name
    user = User.find_by(id: self.user_id)
    if user!=nil && self.freq!=nil
      "#{user.name}, #{self.freq}"
    end
  end
end
