class AddUnderTestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :under_test, :integer
  end
end
