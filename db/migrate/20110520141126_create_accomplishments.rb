class CreateAccomplishments < ActiveRecord::Migration
  def self.up
    create_table :accomplishments do |t|
      t.string :section
      t.integer :linenumber
      t.string :description
      t.integer :skill_id
      t.integer :skillamount
      t.string :otherreward

      t.timestamps
    end
  end

  def self.down
    drop_table :accomplishments
  end
end
