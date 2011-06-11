class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :game_id
      t.string :hashfive
      t.string :player1
      t.string :team1
      t.integer :goals1
      t.string :player2
      t.string :team2
      t.integer :goals2

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
