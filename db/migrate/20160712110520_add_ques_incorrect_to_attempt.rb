class AddQuesIncorrectToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :ques_incorrect, :integer
  end
end
