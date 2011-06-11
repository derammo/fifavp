class Skill < ActiveRecord::Base
	belongs_to :source
	has_many :accomplishments
end
