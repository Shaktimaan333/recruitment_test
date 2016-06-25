class AddLastToScores < ActiveRecord::Migration
  def change
    add_column :scores, :last, :integer
  end
end
