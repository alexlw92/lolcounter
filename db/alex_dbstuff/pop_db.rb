require 'mysql2'
require "active_record"
require "json"
require "net/http"
require "uri"
require "rack/throttle"

apikeyalex = "3a5fa3f0-c714-4a0a-9dab-955dcdc04bca"
apikey = "1b610544-8c97-4f40-adf6-37df27c37fb8"


ActiveRecord::Base.establish_connection(
    :adapter  => 'mysql2',
    :database => 'lolcount',
    :username => 'root',
    :password => 'root',
    :host     => 'localhost')

class Summoners < ActiveRecord::Base
end

class Games < ActiveRecord::Base
end

def callAPI(uri_orig)
  uri = URI.parse(uri_orig)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  begin
    response = http.request(request)
  rescue
    sleep(5)
    return callAPI(uri_orig)
  end

  if response.code == "200"
    result = JSON.parse(response.body)
    return result
  elsif response.code == "429"
    puts "RATE LIMIT"
    puts response.code
    time = response['retry-after']
    if response['X-Rate-Limit-Type'] == 'user'
      abort("ACTUAL RATE LIMIT")
    end
    if time != nil
      sleep(Integer(time))
    else
      sleep(1)
    end
    return callAPI(uri_orig)
  end
end

s = Summoners.order('created_at ASC')

s.each{|ss|

  summoner = ss.id
  puts "getting summoner #{summoner}"
  result = callAPI("https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/#{summoner}?rankedQueues=RANKED_SOLO_5x5&api_key=#{apikey}")
  sleep(0.01)
  begin
    matches = result["matches"].first(10)
  rescue
    next
  end


  matches.each{ |match|
    matchid = match["matchId"]
    matchinfo = callAPI("https://na.api.pvp.net/api/lol/na/v2.2/match/#{matchid}?api_key=#{apikey}")

    matchrecord = Games.find_or_create_by(id: matchid)
    for i in 0..9
      begin

        summId = matchinfo["participantIdentities"][i]["player"]["summonerId"]
        sum = Summoners.find_or_create_by(id: summId)
       # puts "added summoner #{summId}"

        time = matchinfo["matchCreation"]
        dt = Time.at(time/1000)
        matchrecord.update(game_started_at: dt)


        lane = matchinfo["participants"][i]["timeline"]["lane"]
        role = matchinfo["participants"][i]["timeline"]["role"]
        winner = matchinfo["participants"][i]["stats"]["winner"]
        champ = matchinfo["participants"][i]["championId"]
        if winner
          if lane == "TOP"
            matchrecord.update(WIN_TOP: champ)
          elsif lane == "MIDDLE"
            matchrecord.update(WIN_MID: champ)
          elsif lane == "JUNGLE"
            matchrecord.update(WIN_JG: champ)
          elsif lane == "BOTTOM"
            if role == "DUO_CARRY"
              matchrecord.update(WIN_ADC: champ)
            elsif role == "DUO_SUPPORT"
              matchrecord.update(WIN_SUP: champ)
            end
          end
        else
          if lane == "TOP"
            matchrecord.update(LOSE_TOP: champ)
          elsif lane == "MIDDLE"
            matchrecord.update(LOSE_MID: champ)
          elsif lane == "JUNGLE"
            matchrecord.update(LOSE_JG: champ)
          elsif lane == "BOTTOM"
            if role == "DUO_CARRY"
              matchrecord.update(LOSE_ADC: champ)
            elsif role == "DUO_SUPPORT"
              matchrecord.update(LOSE_SUP: champ)
            end
          end
        end

      rescue
      ensure
      end

    end

    puts "added match #{matchid}"

    #sleep(1)


  }
  ss.destroy
}
