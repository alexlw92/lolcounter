class TeamcompController < ApplicationController
  def index
    @blah="blah"
  end

  def search
    top_champ = params[:top]
    jungle_champ = params[:jungle]
    mid_champ = params[:mid]
    adc = params[:adc]
    support = params[:support]

    puts "Inside teamcomp#search!"

    #Do any database access codes below
  end
end
