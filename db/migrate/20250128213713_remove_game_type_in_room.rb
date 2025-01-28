class RemoveGameTypeInRoom < ActiveRecord::Migration[8.0]
  def change
    remove_column :rooms, :game_type
  end
end
