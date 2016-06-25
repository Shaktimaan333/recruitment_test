class AddCategoryNameToExam < ActiveRecord::Migration
  def change
    add_column :exams, :category_name, :string
  end
end
