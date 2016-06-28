class AddAttemptIdToSheet < ActiveRecord::Migration
  def change
    add_column :sheets, :attempt_id, :integer
  end
end
