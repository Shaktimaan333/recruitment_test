class Exam < ActiveRecord::Base
  has_many :ques
  has_many :scores
end
