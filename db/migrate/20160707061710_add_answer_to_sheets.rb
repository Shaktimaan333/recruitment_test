class AddAnswerToSheets < ActiveRecord::Migration
  def change
    add_column :sheets, :answer, :integer
  end
end
