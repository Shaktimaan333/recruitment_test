class AddProfileIdToSheet < ActiveRecord::Migration
  def change
    add_column :sheets, :profile_id, :integer
  end
end
