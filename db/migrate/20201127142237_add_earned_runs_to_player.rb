class AddEarnedRunsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players,:earned_runs,:float
  end
end

