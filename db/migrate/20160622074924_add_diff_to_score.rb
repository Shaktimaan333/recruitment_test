class AddDiffToScore < ActiveRecord::Migration
  def change
    add_column :scores, :diff, :integer
  end
end
