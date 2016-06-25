class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  def display_name
    "#{self.user_id}_#{self.attempt}"
  end
end
