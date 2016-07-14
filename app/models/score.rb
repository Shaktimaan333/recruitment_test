class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  belongs_to :profile
  def display_name
    "#{self.user_id}_#{self.attempt}"
  end
end
