class CreatePositioncoefficients < ActiveRecord::Migration
  def self.up
    create_table :positioncoefficients do |t|
      t.integer :position_id
      t.integer :skill_id
      t.integer :coefficient

      t.timestamps
    end
  end

  def self.down
    drop_table :positioncoefficients
  end
end
