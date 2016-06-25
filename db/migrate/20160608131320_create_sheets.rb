class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :user_id
      t.integer :ques_id
      t.integer :attempt
      t.boolean :one
      t.boolean :two
      t.boolean :three
      t.boolean :four

      t.timestamps null: false
    end
  end
end
