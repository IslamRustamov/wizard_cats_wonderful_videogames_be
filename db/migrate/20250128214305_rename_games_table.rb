class RenameGamesTable < ActiveRecord::Migration[8.0]
  def change
    rename_table :games_tables, :games
  end
end
