class Profile < ActiveRecord::Base
  has_many :sheets
  has_many :attempts
  has_many :scores
  serialize :exams
  before_save { self.exams = exams.split(',')}
  validates :name, presence: true
  validates :exams, presence: true
  private
  def convertarray
    self.exams = exams.split(",")
  end
end
