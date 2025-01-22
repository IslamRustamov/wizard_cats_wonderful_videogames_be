class AddRoomWinnerToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :winner_id, :string
  end
end
