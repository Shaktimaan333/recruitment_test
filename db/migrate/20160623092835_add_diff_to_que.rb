class AddDiffToQue < ActiveRecord::Migration
  def change
    add_column :ques, :diff, :integer
  end
end
