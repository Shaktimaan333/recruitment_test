class Profile < ActiveRecord::Base
  has_many :sheets
  has_many :attempts
  has_many :scores
  serialize :exams, Array
end
