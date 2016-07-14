class AddProfileIdToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :profile_id, :integer
  end
end
