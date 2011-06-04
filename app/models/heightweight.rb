class Heightweight < ActiveRecord::Base
  has_many :heightweightvalues, :dependent => :destroy
  accepts_nested_attributes_for :heightweightvalues
end
