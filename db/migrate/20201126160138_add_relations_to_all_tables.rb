class AddRelationsToAllTables < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues,:season_id,:integer
    add_column :divisions,:league_id,:integer
    add_column :teams,:division_id,:integer
    add_column :players,:team_id,:integer
    add_column :players,:league_id,:integer
  end
end
