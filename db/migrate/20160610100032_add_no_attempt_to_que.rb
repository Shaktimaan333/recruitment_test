class AddNoAttemptToQue < ActiveRecord::Migration
  def change
    add_column :ques, :no_attempt, :integer
  end
end
