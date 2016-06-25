class AddCorrectAttemptToQue < ActiveRecord::Migration
  def change
    add_column :ques, :correct_attempt, :integer
  end
end
