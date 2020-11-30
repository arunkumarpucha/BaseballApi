class AddSomeColumnsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players,:innings,:float
    add_column :players,:hit_batter,:float
    add_column :players,:wild_pitches,:float
  end
end
