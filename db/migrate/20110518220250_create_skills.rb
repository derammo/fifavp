class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :name
      t.string :description
      t.integer :source_id

      t.timestamps
    end
  end

  def self.down
    drop_table :skills
  end
end
