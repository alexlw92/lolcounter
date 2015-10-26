class SummonerController < ApplicationController
  def index
    @blah="blah"
  end

  def show
    @blah2="blah2"
    input_summoner_id = params[:id]
    @output_id = input_summoner_id

  end

  def search

    input_name = params[:input_name]
    input_region = params[:input_region]


    @output_summoner_name = input_name
    @output_summoner_region = input_region


  end

end
