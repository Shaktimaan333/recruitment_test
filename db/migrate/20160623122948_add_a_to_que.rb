class AddAToQue < ActiveRecord::Migration
  def change
    add_column :ques, :a, :decimal
  end
end
