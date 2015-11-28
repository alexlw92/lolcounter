class SummonerController < ApplicationController
  def index

    input_name = params[:input_name]
    input_region = params[:input_region]
    @displayInfo = false

    # PARSE JSON
    if input_name and input_region != nil
      @displayInfo = true

      input_name = input_name.gsub(/\s+/, "")

      result = RiotApiModel.summoner_lookup(input_name,input_region)
      if result.is_a?Integer
        @valid_sum_name = "nope"
      else
        @valid_sum_name = 'valid'
        @output_summoner_name = result[input_name]['name']
        @output_summoner_region = input_region.upcase
        summoner_level = result[input_name]['summonerLevel']
        summoner_icon = result[input_name]['profileIconId']
        @output_summoner_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/profileicon/' + summoner_icon.to_s + '.png'

        if summoner_level < 30
          @output_summoner_rank = 'Level ' + summoner_level.to_s
          @valid_rank = 'no'

        else
          summoner_id = result[input_name]['id']

          result2 = RiotApiModel.rank_lookup(summoner_id, input_region)

          if result2.is_a?Integer
            @output_summoner_rank = 'No solo queue ranked data found!'
          else

            if result2[summoner_id.to_s][0]['queue'].to_s != 'RANKED_SOLO_5x5'
              @valid_rank = 'no'
              @output_summoner_rank = 'No solo queue ranked data found!'
            else

              summoner_tier = result2[summoner_id.to_s][0]['tier']
              summoner_division = result2[summoner_id.to_s][0]['entries'][0]['division']
              summoner_lp =  result2[summoner_id.to_s][0]['entries'][0]['leaguePoints']
              @output_summoner_rank = summoner_tier.to_s + ' ' + summoner_division.to_s + ' ' + summoner_lp.to_s + 'LP'

              result3 = RiotApiModel.get_ranked_summary(summoner_id)

              if result3.is_a?Integer
                @valid_rank = 'no'
                @output_summoner_rank = 'No solo queue ranked data found!'
              else
                @valid_rank = 'valid'
                arr = result3['champions']

                #Sorts arr in increasing order
                #Last element is total stats
                #2nd last is most played
                #3rd last is 2nd most played
                #4th last is the 3rd most played

                arr.sort! {|a,b| a['stats']['totalSessionsPlayed'] <=> b['stats']['totalSessionsPlayed'] }

                top1_num = arr[arr.length-2]['stats']['totalSessionsPlayed']
                top1_id = arr[arr.length-2]['id']
                top2_num = arr[arr.length-3]['stats']['totalSessionsPlayed']
                top2_id = arr[arr.length-3]['id']
                top3_num = arr[arr.length-4]['stats']['totalSessionsPlayed']
                top3_id = arr[arr.length-4]['id']

                top1_wins = arr[arr.length-2]['stats']['totalSessionsWon']
                top2_wins = arr[arr.length-3]['stats']['totalSessionsWon']
                top3_wins = arr[arr.length-4]['stats']['totalSessionsWon']


                top1_champ = RiotApiModel.get_champion_by_id(top1_id)['name']
                top2_champ = RiotApiModel.get_champion_by_id(top2_id)['name']
                top3_champ = RiotApiModel.get_champion_by_id(top3_id)['name']

                @output_top1_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + top1_champ.to_s + '.png'
                @output_top2_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + top2_champ.to_s + '.png'
                @output_top3_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + top3_champ.to_s + '.png'

                @output_top1_champ = top1_champ
                @output_top2_champ = top2_champ
                @output_top3_champ = top3_champ

                @output_top1_games = top1_num
                @output_top2_games = top2_num
                @output_top3_games = top3_num

                @output_top1_wr = ((top1_wins+0.0)*100/ top1_num).to_i
                @output_top2_wr = ((top2_wins+0.0)*100/ top2_num).to_i
                @output_top3_wr = ((top3_wins+0.0)*100/ top3_num).to_i

                @output_top1_k = ((arr[arr.length-2]['stats']['totalChampionKills'] +0.0) / top1_num).round(1)
                @output_top2_k = ((arr[arr.length-3]['stats']['totalChampionKills'] +0.0) / top2_num).round(1)
                @output_top3_k = ((arr[arr.length-4]['stats']['totalChampionKills'] +0.0) / top3_num).round(1)

                @output_top1_d = ((arr[arr.length-2]['stats']['totalDeathsPerSession'] +0.0) / top1_num).round(1)
                @output_top2_d = ((arr[arr.length-3]['stats']['totalDeathsPerSession'] +0.0) / top2_num).round(1)
                @output_top3_d = ((arr[arr.length-4]['stats']['totalDeathsPerSession'] +0.0) / top3_num).round(1)

                @output_top1_a = ((arr[arr.length-2]['stats']['totalAssists'] +0.0) / top1_num).round(1)
                @output_top2_a = ((arr[arr.length-3]['stats']['totalAssists'] +0.0) / top2_num).round(1)
                @output_top3_a = ((arr[arr.length-4]['stats']['totalAssists'] +0.0) / top3_num).round(1)
              end


            end
          end
        end
      end
    end
  end

  def show
    @blah2="blah2"
    input_summoner_id = params[:id]
    @output_id = input_summoner_id

  end

end
