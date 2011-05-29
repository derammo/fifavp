require './lib/authenticated_system.rb'

class ApplicationController < ActionController::Base
  # authentication support
  include AuthenticatedSystem
  protect_from_forgery 
end
