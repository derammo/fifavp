class Player < ActiveRecord::Base
	has_many :playeraccomplishments, :dependent => :destroy
	has_many :leagueplayers, :dependent => :destroy
	has_many :games
end
