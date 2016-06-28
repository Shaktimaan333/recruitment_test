class Attempt < ActiveRecord::Base
  has_many :sheets
  belongs_to :user
  belongs_to :exam
end
