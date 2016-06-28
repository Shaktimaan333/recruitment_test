class Exam < ActiveRecord::Base
  has_many :ques, through: :categorys
  has_many :scores
  has_many :attempts
  has_many :categorys
  def display_name
    "#{self.topic}"
  end
end
