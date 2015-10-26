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

    @output_summoner_name = params[:title]
  end

end
