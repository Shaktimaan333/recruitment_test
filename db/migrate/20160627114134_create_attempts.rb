class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :freq

      t.timestamps null: false
    end
  end
end
