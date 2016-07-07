class AddAverageToExam < ActiveRecord::Migration
  def change
    add_column :exams, :average, :float
  end
end
