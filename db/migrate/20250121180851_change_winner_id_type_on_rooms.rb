class ChangeWinnerIdTypeOnRooms < ActiveRecord::Migration[8.0]
  def change
    change_column :rooms, :winner_id, :integer
  end
end
