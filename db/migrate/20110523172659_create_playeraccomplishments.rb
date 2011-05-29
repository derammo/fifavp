class CreatePlayeraccomplishments < ActiveRecord::Migration
  def self.up
    create_table :playeraccomplishments do |t|
      t.integer :player_id
      t.integer :accomplishment_id
      t.boolean :achieved
      t.datetime :when

      t.timestamps
    end
  end

  def self.down
    drop_table :playeraccomplishments
  end
end
