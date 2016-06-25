class AddUpdatedToSheets < ActiveRecord::Migration
  def change
    add_column :sheets, :updated, :integer
  end
end
