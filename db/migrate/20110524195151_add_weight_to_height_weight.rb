class AddWeightToHeightWeight < ActiveRecord::Migration
  def self.up
 	add_column :heightweights, :weight, :integer
  end

  def self.down
 	remove_column :heightweights, :weight
  end
end
