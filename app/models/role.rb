class Role < ActiveRecord::Base
	has_many :rolevalues, :dependent => :destroy
  accepts_nested_attributes_for :rolevalues
	has_many :assignments, :dependent => :destroy
end
