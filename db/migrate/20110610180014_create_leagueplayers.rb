class CreateLeagueplayers < ActiveRecord::Migration
  def self.up
    create_table :leagueplayers do |t|
      t.integer :league_id
      t.integer :player_id
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :leagueplayers
  end
end
