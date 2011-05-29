class Skill < ActiveRecord::Base
	belongs_to :source
	# has_many :rolevalues
	# has_many :heightweightvalues
	has_many :accomplishments
end
