class CreateHeightweightvalues < ActiveRecord::Migration
  def self.up
    create_table :heightweightvalues do |t|
      t.integer :heightweight_id
      t.integer :skill_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :heightweightvalues
  end
end
