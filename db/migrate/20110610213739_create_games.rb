class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :league_id
      t.integer :player1_id
      t.integer :player2_id
      t.integer :result_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
