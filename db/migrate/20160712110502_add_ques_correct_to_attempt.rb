class AddQuesCorrectToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :ques_correct, :integer
  end
end
