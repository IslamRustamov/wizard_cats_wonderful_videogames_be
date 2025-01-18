class AddPlayersToRoom < ActiveRecord::Migration[8.0]
  def change
    change_table :players do |t|
      t.belongs_to :room
    end
  end
end
