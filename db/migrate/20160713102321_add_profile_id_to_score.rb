class AddProfileIdToScore < ActiveRecord::Migration
  def change
    add_column :scores, :profile_id, :integer
  end
end
