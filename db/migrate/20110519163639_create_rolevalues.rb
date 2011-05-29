class CreateRolevalues < ActiveRecord::Migration
  def self.up
    create_table :rolevalues do |t|
      t.integer :role_id
      t.integer :skill_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :rolevalues
  end
end
