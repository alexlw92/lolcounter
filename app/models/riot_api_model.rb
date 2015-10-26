class RiotApiModel < ActiveRecord::Base
  require 'rest_client'

  


  def self.summoner_lookup(sum_name,sum_region)
    url ="https://#{sum_region}.api.pvp.net/api/lol/#{sum_region}/v1.4/summoner/by-name/#{sum_name}?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    result = RestClient.get(url, :accept => 'json')
    return JSON.parse(result)
  end

  def self.rank_lookup(sum_id, sum_region)
    url = "https://#{sum_region}.api.pvp.net/api/lol/#{sum_region}/v2.5/league/by-summoner/#{sum_id}/entry?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    result = RestClient.get(url, :accept => 'json')
    return JSON.parse(result)

  end

end