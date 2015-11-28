class RiotApiModel < ActiveRecord::Base
  require 'rest_client'



  def self.summoner_lookup(sum_name,sum_region)
    url ="https://#{sum_region}.api.pvp.net/api/lol/#{sum_region}/v1.4/summoner/by-name/#{sum_name}?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    #result = RestClient.get(url, :accept => 'json')

    RestClient.get(url){ |response, request, result, &block|
      case response.code
        when 200
          return JSON.parse(response)
        else
          return response.code
      end
    }

  end

  def self.rank_lookup(sum_id, sum_region)
    url = "https://#{sum_region}.api.pvp.net/api/lol/#{sum_region}/v2.5/league/by-summoner/#{sum_id}/entry?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    #result = RestClient.get(url, :accept => 'json')

    RestClient.get(url){ |response, request, result, &block|
      case response.code
        when 200
          return JSON.parse(response)
        else
          return response.code
      end
    }

  end

  def self.get_champions()
    url = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    result = RestClient.get(url, :accept => 'json')
    return JSON.parse(result)
  end

  def self.get_ranked_summary(sum_id)
    url = "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/#{sum_id}/ranked?season=SEASON2015&api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    RestClient.get(url){ |response, request, result, &block|
      case response.code
        when 200
          return JSON.parse(response)
        else
          return response.code
      end
    }
    #result = RestClient.get(url, :accept => 'json')
    #return JSON.parse(result)
  end

  def self.get_champion_by_id(champ_id)
    url = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/#{champ_id}?api_key=80f2a95e-b7f8-44d0-894b-b02201b98dc0"
    result = RestClient.get(url, :accept => 'json')
    return JSON.parse(result)
  end

end