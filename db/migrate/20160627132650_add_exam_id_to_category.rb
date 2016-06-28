class AddExamIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :exam_id, :integer
  end
end
