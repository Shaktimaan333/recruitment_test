class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :attempt
      t.integer :mark
      t.integer :exam_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
