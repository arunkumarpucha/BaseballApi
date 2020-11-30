class RenameColumnErrorsInPlayers < ActiveRecord::Migration[5.2]
  def change
    rename_column :players,:errors,:bs_errors
  end
end
