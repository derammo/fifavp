module PlayersHelper
  require 'httparty'

  class AccomplishmentsDownload
    include HTTParty
    base_uri 'http://www.ea.com/uk/football/services'
    # /getdata
    # ?platformTag=soccer-fifa-11-360&handle=GinTonicLime&platform=360'
    default_params :output => 'json'
    format :json
  end
end
