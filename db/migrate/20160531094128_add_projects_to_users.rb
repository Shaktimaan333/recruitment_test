class AddProjectsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :projects, :string
  end
end
