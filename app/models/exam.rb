class Exam < ActiveRecord::Base
  has_many :ques
  has_many :scores
  has_many :attempts
  has_many :categorys
end
