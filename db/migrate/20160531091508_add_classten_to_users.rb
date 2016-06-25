class AddClasstenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :classten, :string
  end
end
