class AddThrowsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players,:throws,:string
  end
end
