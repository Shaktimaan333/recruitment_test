class AddFreqToUsers < ActiveRecord::Migration
  def change
    add_column :users, :freq, :integer
  end
end
