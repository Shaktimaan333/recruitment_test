class AddWrongAttemptToQue < ActiveRecord::Migration
  def change
    add_column :ques, :wrong_attempt, :integer
  end
end
