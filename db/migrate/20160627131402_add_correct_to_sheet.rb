class AddCorrectToSheet < ActiveRecord::Migration
  def change
    add_column :sheets, :correct, :boolean
  end
end
