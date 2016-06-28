class ChangeDifficultyInQues < ActiveRecord::Migration
  def self.up
    change_column :ques, :diff, :decimal
  end

  def self.down
    change_column :ques, :diff, :integer
  end
end
