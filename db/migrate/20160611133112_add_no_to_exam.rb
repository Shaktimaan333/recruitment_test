class AddNoToExam < ActiveRecord::Migration
  def change
    add_column :exams, :no, :integer
  end
end
