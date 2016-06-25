class CreateMiscs < ActiveRecord::Migration
  def change
    create_table :miscs do |t|
      t.integer :user_id
      t.integer :attempt
      t.boolean :terms

      t.timestamps null: false
    end
  end
end
