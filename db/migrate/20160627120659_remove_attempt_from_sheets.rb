class RemoveAttemptFromSheets < ActiveRecord::Migration
  def change
    remove_column :sheets, :attempt, :integer
  end
end
