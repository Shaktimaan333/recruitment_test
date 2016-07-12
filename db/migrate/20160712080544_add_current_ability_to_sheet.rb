class AddCurrentAbilityToSheet < ActiveRecord::Migration
  def change
    add_column :sheets, :current_ability, :float
  end
end
