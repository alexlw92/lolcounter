class TeamcompController < ApplicationController
  def index
    top_champ = params[:top]
    jungle_champ = params[:jungle]
    mid_champ = params[:mid]
    adc = params[:adc]
    support = params[:support]

    #puts "DEBUG: Inside teamcomp#index!"

    #Do any database access codes below
    @games = Game.all
    #    @wins = @games.where(WIN_TOP:@top.id,WIN_JG:@jg.id,WIN_MID:@mid.id,WIN_ACD:@adc.id,WIN_SUP:@sup.id).count
    #    @losses = @games.where(LOSE_TOP:@top.id,LOSE_JG:@jg.id,LOSE_MID:@mid.id,LOSE_ACD:@adc.id,LOSE_SUP:@sup.id).count
    @wins = 3
    @losses = 1
  end
end
