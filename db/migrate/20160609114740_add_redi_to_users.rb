class AddRediToUsers < ActiveRecord::Migration
  def change
    add_column :users, :redi, :integer
  end
end
