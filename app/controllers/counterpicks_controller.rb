class CounterpicksController < ApplicationController
  def index
    lane = params[:lane] #Lane the user searched for
    championSearched = params[:champSearch] #Champion user wishes to find counters for

    @lane = lane
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
      @first_counter = @counters.pluck(:first_counter_name)
      @wins_against_first = @counters.pluck(:wins_against_first)
      @losses_against_first = @counters.pluck(:losses_against_first)
      @second_counter = @counters.pluck(:second_counter_name)
      @wins_against_second = @counters.pluck(:wins_against_second)
      @losses_against_second = @counters.pluck(:losses_against_second)
      @third_counter = @counters.pluck(:third_counter_name)
      @wins_against_third = @counters.pluck(:wins_against_third)
      @losses_against_third = @counters.pluck(:losses_against_third)
      @valid = 1
    end

  end
end
