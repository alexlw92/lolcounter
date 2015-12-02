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

  def self.get_counters(champ_id, role)
    sql = "SELECT
    L.lose_#{role} as opponent,
    IFNULL(L.c, 0) as wins,
    IFNULL(W.c, 0) as losses,
    IFNULL(L.c, 0)+IFNULL(W.c, 0) as games,
    IFNULL(L.c, 0)/(IFNULL(L.c, 0)+IFNULL(W.c, 0)) as winrate
FROM
    (SELECT
        lose_#{role}, COUNT(1) c
    FROM
        games
    WHERE
        win_#{role} = #{champ_id}
    GROUP BY lose_#{role}) L
        LEFT JOIN
    (SELECT
        win_#{role}, COUNT(1) c
    FROM
        games
    WHERE
        lose_#{role} = #{champ_id}
    GROUP BY win_#{role}) W ON L.lose_#{role} = W.win_#{role}
    WHERE IFNULL(L.c, 0)+IFNULL(W.c, 0) > 10
    ORDER BY winrate ASC
    LIMIT 3"
    results = ActiveRecord::Base.connection.execute(sql).as_json
    counter = Counter.find_or_create_by(champion_id: champ_id, role: role)
    it = 1
    results.each{ |c|
      if(it==1)
        counter.update(first_counter_name: Champion.find_by_id(results[0][0]).name)
        counter.update(wins_against_first: results[0][1])
        counter.update(losses_against_first: results[0][2])
      elsif(it==2)
        counter.update(second_counter_name: Champion.find_by_id(results[1][0]).name)
        counter.update(wins_against_second: results[1][1])
        counter.update(losses_against_second: results[1][2])
      elsif(it==3)
        counter.update(third_counter_name: Champion.find_by_id(results[2][0]).name)
        counter.update(wins_against_third: results[2][1])
        counter.update(losses_against_third: results[2][2])

      end
      it=it+1
    }
  end
end