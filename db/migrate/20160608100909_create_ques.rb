class CreateQues < ActiveRecord::Migration
  def change
    create_table :ques do |t|
      t.integer :category_id
      t.string :question
      t.string :one
      t.string :two
      t.string :three
      t.string :four
      t.string :correct

      t.timestamps null: false
    end
  end
end
