class RenameColumnInPlayers < ActiveRecord::Migration[5.2]
  def change
    rename_column :players,:sacrifice_files,:sacrifice_flies
  end
end
