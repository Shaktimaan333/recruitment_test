class AddMarkToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :mark, :integer
  end
end
