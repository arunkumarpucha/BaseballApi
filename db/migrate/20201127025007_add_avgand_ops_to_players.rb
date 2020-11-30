class AddAvgandOpsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players,:avg,:float
    add_column :players,:ops,:float
  end
end
