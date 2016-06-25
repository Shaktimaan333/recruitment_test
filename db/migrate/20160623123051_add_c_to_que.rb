class AddCToQue < ActiveRecord::Migration
  def change
    add_column :ques, :c, :decimal
  end
end
