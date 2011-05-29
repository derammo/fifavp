class Position < ActiveRecord::Base
	has_many :positioncoefficients
	has_many :assignments
end
