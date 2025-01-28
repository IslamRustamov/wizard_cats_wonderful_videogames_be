class CreateGamesTable < ActiveRecord::Migration[8.0]
  def change
    create_table :games_tables do |t|
      t.string :name
      t.string :min_players
      t.string :max_players
      t.belongs_to :room

      t.timestamps
    end
  end
end
