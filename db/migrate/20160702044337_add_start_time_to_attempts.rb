class AddStartTimeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :start_time, :datetime
  end
end
