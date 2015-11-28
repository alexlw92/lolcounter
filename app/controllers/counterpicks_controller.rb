class CounterpicksController < ApplicationController
  def index
    lane = params[:lane] #Lane the user searched for
    championSearched = params[:champSearch] #Champion user wishes to find counters for

    @lane = lane
    @output_lane = lane.to_s.capitalize
    @champion_name = championSearched
    #Do any database access codes below
    @champion = Champion.all
    @counters = Counter.all

    @valid = 0
    @champion_id = @champion.where(name:@champion_name).pluck(:id)

    if(@lane == nil)
      @valid = 2
    end

    if(!@champion_id.blank?)
      @counters = @counters.where(id:@champion_id)

      first_counter = @counters.pluck(:first_counter_name)
      @first_counter_name = first_counter[0]
      @first_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @first_counter_name.to_s + '.png'

      wins_against_first = @counters.pluck(:wins_against_first)
      losses_against_first = @counters.pluck(:losses_against_first)
      @first_games = wins_against_first[0] + losses_against_first[0]
      @first_wr = ((wins_against_first+0.0)*100/ @first_games).to_i

      second_counter = @counters.pluck(:second_counter_name)
      @second_counter_name = second_counter[0]
      @second_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @second_counter_name.to_s + '.png'

      wins_against_second = @counters.pluck(:wins_against_second)
      losses_against_second = @counters.pluck(:losses_against_second)
      @second_games = wins_against_second[0] + losses_against_second[0]
      @second_wr = ((wins_against_second+0.0)*100/ @second_games).to_i

      third_counter = @counters.pluck(:third_counter_name)
      @third_counter_name = third_counter[0]
      @third_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + @third_counter_name.to_s + '.png'

      wins_against_third = @counters.pluck(:wins_against_third)
      losses_against_third = @counters.pluck(:losses_against_third)
      @third_games = wins_against_third[0] + losses_against_third[0]
      @third_wr = ((wins_against_third+0.0)*100/ @third_games).to_i

      p first_counter
      p first_counter[0]


      @valid = 1
    end

  end
end
