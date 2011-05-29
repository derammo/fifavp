class AddIndexing < ActiveRecord::Migration
  def self.up
    add_index :skills, :source_id
    add_index :positioncoefficients, :position_id
    add_index :positioncoefficients, :skill_id
    add_index :rolevalues, :role_id
    add_index :rolevalues, :skill_id
    add_index :heightweightvalues, :heightweight_id
    add_index :heightweightvalues, :skill_id
    add_index :assignments, :role_id
    add_index :assignments, :position_id
    add_index :accomplishments, :skill_id
    add_index :playeraccomplishments, :player_id
    add_index :playeraccomplishments, :accomplishment_id
  end

  def self.down
    remove_index :skills, :source_id
    remove_index :positioncoefficients, :position_id
    remove_index :positioncoefficients, :skill_id
    remove_index :rolevalues, :role_id
    remove_index :rolevalues, :skill_id
    remove_index :heightweightvalues, :heightweight_id
    remove_index :heightweightvalues, :skill_id
    remove_index :assignments, :role_id
    remove_index :assignments, :position_id
    remove_index :accomplishments, :skill_id
    remove_index :playeraccomplishments, :player_id
    remove_index :playeraccomplishments, :accomplishment_id
 end
end
