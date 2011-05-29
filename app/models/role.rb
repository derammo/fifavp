class Role < ActiveRecord::Base
	has_many :rolevalues
	has_many :assignments
end
