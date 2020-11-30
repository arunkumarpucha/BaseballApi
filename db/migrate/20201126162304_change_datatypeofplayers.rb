class ChangeDatatypeofplayers < ActiveRecord::Migration[5.2]
  def change
    change_column :players,:games,:float
    change_column :players,:games_started,:float
    change_column :players,:at_bats,:float
    change_column :players,:runs,:float
    change_column :players,:hits,:float
    change_column :players,:doubles,:float
    change_column :players,:triples,:float
    change_column :players,:home_runs,:float
    change_column :players,:rbi,:float
    change_column :players,:steals,:float
    change_column :players,:caught_stealing,:float
    change_column :players,:sacrifice_hits,:float
    change_column :players,:sacrifice_files,:float
    change_column :players,:errors,:float
    change_column :players,:pb,:float
    change_column :players,:walks,:float
    change_column :players,:struck_out,:float
    change_column :players,:hit_by_pitch,:float

  end
end


