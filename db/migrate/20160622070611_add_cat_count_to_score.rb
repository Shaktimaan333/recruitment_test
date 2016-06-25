class AddCatCountToScore < ActiveRecord::Migration
  def change
    add_column :scores, :cat_count, :integer
  end
end
