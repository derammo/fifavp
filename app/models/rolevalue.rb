class Rolevalue < ActiveRecord::Base
	belongs_to :role
	belongs_to :skill
end
