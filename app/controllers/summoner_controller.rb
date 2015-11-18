class SummonerController < ApplicationController
  def index

    input_name = params[:input_name]
    input_region = params[:input_region]
    @displayInfo = false

    # VALIDATION


    # PARSE JSON
    if input_name and input_region != nil
      @displayInfo = true

      result = RiotApiModel.summoner_lookup(input_name,input_region)
      @output_summoner_name = result[input_name]['name']
      @output_summoner_region = input_region.upcase
      summoner_level = result[input_name]['summonerLevel']

      summoner_icon = result[input_name]['profileIconId']
      @output_summoner_icon = 'http://ddragon.leagueoflegends.com/cdn/5.20.1/img/profileicon/' + summoner_icon.to_s + '.png'
      p @output_summoner_icon
      summoner_id = result[input_name]['id']

      result2 = RiotApiModel.rank_lookup(summoner_id, input_region)

      summoner_tier = result2[summoner_id.to_s][0]['tier']
      summoner_division = result2[summoner_id.to_s][0]['entries'][0]['division']
      summoner_lp =  result2[summoner_id.to_s][0]['entries'][0]['leaguePoints']

      puts('------------------')
      p summoner_icon
      p summoner_tier
      p summoner_division
      p summoner_lp

      @output_summoner_tier = summoner_tier
      @output_summoner_divison = summoner_division
      @output_summoner_lp = summoner_lp

      result3 = RiotApiModel.get_ranked_summary(summoner_id)
      arr = result3['champions']

      #Sorts arr in increasing order
      #Last element is total stats
      #2nd last is most played
      #3rd last is 2nd most played
      #4th last is the 3rd most played

      arr.sort! {|a,b| a['stats']['totalSessionsPlayed'] <=> b['stats']['totalSessionsPlayed'] }
        p arr[0]['stats']['totalSessionsPlayed']
    end
  end

  def show
    @blah2="blah2"
    input_summoner_id = params[:id]
    @output_id = input_summoner_id

  end

end
