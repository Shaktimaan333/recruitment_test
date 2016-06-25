class Sheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :que
  def display_name
    "#{self.user_id} #{self.attempt}"
  end
end
