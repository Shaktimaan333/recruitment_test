class AddAttemptIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :attempt_id, :integer
  end
end
