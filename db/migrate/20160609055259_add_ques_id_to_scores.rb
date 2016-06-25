class AddQuesIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :ques_id, :integer
  end
end
