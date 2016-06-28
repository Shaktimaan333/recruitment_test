class Sheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :que
  belongs_to :attempt
  #def display_name
  #  "#{self.user_id} #{self.attempt}"
  #end
end
