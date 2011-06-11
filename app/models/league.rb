class League < ActiveRecord::Base
	has_many :leagueplayers, :dependent => :destroy
  accepts_nested_attributes_for :leagueplayers
	has_many :games, :dependent => :destroy
end
