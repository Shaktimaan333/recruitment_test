class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :sheets, :user_id
  end
end
