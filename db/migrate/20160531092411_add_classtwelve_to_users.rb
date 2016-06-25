class AddClasstwelveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :classtwelve, :string
  end
end
