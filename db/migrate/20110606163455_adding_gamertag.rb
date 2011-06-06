class AddingGamertag < ActiveRecord::Migration
  def self.up
 	add_column :players, :gamertag, :string
  end

  def self.down
 	remove_column :players, :gamertag
  end
end
