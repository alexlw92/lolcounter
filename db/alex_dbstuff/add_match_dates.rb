require 'mysql2'
require "active_record"
require "json"
require "net/http"
require "uri"

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

def call_URI(uri)
  uri = URI.parse(uri)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.request_uri)
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  response = http.request(request)
  if response.code == "200"
    return JSON.parse(response.body)
  else
  end
end

matchid = 2000516317

games = Games.all.where(game_started_at: [false, nil]).order(id: :desc)

games.each do |game|
  matchid = game.id
  result = call_URI("https://na.api.pvp.net/api/lol/na/v2.2/match/#{matchid}?api_key=3a5fa3f0-c714-4a0a-9dab-955dcdc04bca")
  time = result["matchCreation"]
  dt = Time.at(time/1000)
  game.update(game_started_at: dt)
  puts "added date#{dt} for game #{matchid}"
  sleep(1.2)
end


