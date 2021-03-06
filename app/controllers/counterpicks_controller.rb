class CounterpicksController < ApplicationController
  def index
    expires_in 10.minutes, :public => true
    lane = params[:lane] #Lane the user searched for
    championSearched = params[:champSearch] #Champion user wishes to find counters for

    if(lane == nil && championSearched == nil) #Haven't queried anything
      @valid = 4
      return
    end
    @lane = lane
    @output_lane = lane.to_s.capitalize
    @champion_name = championSearched
    #Do any database access codes below
    @champion = Champion.all
    @counters = Counter.all

    @valid = 0
    @champion_id = @champion.where(nickname:@champion_name).pluck(:id)

    if(@lane == nil) #Invalid lane in argument
      @valid = 3
    end

    if(!@champion_id.blank?) #Checks if the searched champion is a valid champion
      @counters = @counters.where(champion_id:@champion_id, role: @lane)

      first_counter = @counters.pluck(:first_counter_name)
      if(first_counter.blank?) #We found no entries for 1st counter against the queried champion
        @valid = 2
        return
      end
      @first_counter_name = @champion.where(id:first_counter[0]).pluck(:name)[0]
      if(@first_counter_name == nil)
        @valid = 2
        return
      end
      @first_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @first_counter_name + '.png'
      @first_counter_name = @champion.where(id:first_counter[0]).pluck(:nickname)[0]

      wins_against_first = @counters.pluck(:wins_against_first)
      losses_against_first = @counters.pluck(:losses_against_first)
      @first_games = wins_against_first[0] + losses_against_first[0]
      @first_wr = ((wins_against_first[0]+0.0)*100/ @first_games).to_i

      second_counter = @counters.pluck(:second_counter_name)
      if(second_counter.blank?) #We found no entries for 2nd counter against the queried champion
        @valid = 2
        return
      end
      @second_counter_name = @champion.where(id:second_counter[0]).pluck(:name)[0]
      if(@second_counter_name == nil)
        @valid = 1
        return
      end
      @second_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @second_counter_name + '.png'
      @second_counter_name = @champion.where(id:second_counter[0]).pluck(:nickname)[0]

      wins_against_second = @counters.pluck(:wins_against_second)
      losses_against_second = @counters.pluck(:losses_against_second)
      @second_games = wins_against_second[0] + losses_against_second[0]
      @second_wr = ((wins_against_second[0]+0.0)*100/ @second_games).to_i

      third_counter = @counters.pluck(:third_counter_name)
      if(third_counter.blank?) #We found no entries for 3d counter against the queried champion
        @valid = 2
        return
      end
      @third_counter_name = @champion.where(id:third_counter[0]).pluck(:name)[0]
      if(@third_counter_name == nil)
        @valid = 1
        return
      end
      @third_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @third_counter_name + '.png'
      @third_counter_name = @champion.where(id:third_counter[0]).pluck(:nickname)[0]

      wins_against_third = @counters.pluck(:wins_against_third)
      losses_against_third = @counters.pluck(:losses_against_third)
      @third_games = wins_against_third[0] + losses_against_third[0]
      @third_wr = ((wins_against_third[0]+0.0)*100/ @third_games).to_i

      @valid = 1
    end
  end
end
