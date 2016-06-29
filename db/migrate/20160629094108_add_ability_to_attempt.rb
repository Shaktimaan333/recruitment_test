class AddAbilityToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :ability, :float
  end
end
