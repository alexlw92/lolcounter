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

begin
ensure
end
uri = URI.parse("https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/21589096?rankedQueues=RANKED_SOLO_5x5&api_key=3a5fa3f0-c714-4a0a-9dab-955dcdc04bca")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.request(request)
if response.code == "200"
  result = JSON.parse(response.body)
else
end
puts result
puts result["matches"]

