class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :game_type
      t.string :status
      t.string :password

      t.timestamps
    end
  end
end
