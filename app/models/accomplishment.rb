class Accomplishment < ActiveRecord::Base
	belongs_to :skill
	has_many :playeraccomplishments
	# has_many :players, :through => :playeraccomplishments
end
