class AddMobilenoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobileno, :string
  end
end
