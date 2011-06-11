class Leagueplayer < ActiveRecord::Base
	belongs_to :league
	belongs_to :player
end
