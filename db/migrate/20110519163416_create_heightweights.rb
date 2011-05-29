class CreateHeightweights < ActiveRecord::Migration
  def self.up
    create_table :heightweights do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :heightweights
  end
end
