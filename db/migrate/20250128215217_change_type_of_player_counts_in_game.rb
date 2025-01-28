class ChangeTypeOfPlayerCountsInGame < ActiveRecord::Migration[8.0]
  def change
    change_column :games, :min_players, :integer
    change_column :games, :max_players, :integer
  end
end
