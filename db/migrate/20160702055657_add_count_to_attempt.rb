class AddCountToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :count, :integer, :null => false, :default => 0
  end
end
