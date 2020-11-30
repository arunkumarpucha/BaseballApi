class AddExtraColumnsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players,:wins,:float
    add_column :players,:losses,:float
    add_column :players,:saves,:float
    add_column :players,:complete_games,:float
    add_column :players,:shut_outs,:float
    add_column :players,:era,:float
    add_column :players,:walked_batter,:float
    add_column :players,:balk,:float
    add_column :players,:struck_out_batter,:float
  end
end
