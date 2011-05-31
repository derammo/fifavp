class HomeController < ApplicationController
  layout 'general'
  
  def index
    if current_user then
      @playerexists = Player.all(:conditions=> ['LOWER(owner) = ?', current_user.login]).count > 0
    else
      @playerexists = false
    end
  end

end
