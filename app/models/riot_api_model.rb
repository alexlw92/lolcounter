class RiotApiModel < ActiveRecord::Base
  require 'rest_client'

  #@url

  #def self.getData
  #  response = RestClient(@url, { :content_type => :json, "Api-Key" => "80f2a95e-b7f8-44d0-894b-b02201b98dc0" })
  #  return response;
  #end

  def self.retrieve_results(myParameter)
    url = "https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{myParameter}?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    result = RestClient.get(url, :accept => 'json')
    return JSON.parse(result);
    #JSON.parse(RiotApiModel.getData)
  end
end