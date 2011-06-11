class Position < ActiveRecord::Base
	has_many :positioncoefficients, :dependent => :destroy
	has_many :assignments, :dependent => :destroy
end
