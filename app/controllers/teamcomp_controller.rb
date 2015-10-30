class TeamcompController < ApplicationController
  def index
  end

  def show
    @games = Game.all
#    @wins = @games.where(WIN_TOP:@top.id,WIN_JG:@jg.id,WIN_MID:@mid.id,WIN_ACD:@adc.id,WIN_SUP:@sup.id).count
#    @losses = @games.where(LOSE_TOP:@top.id,LOSE_JG:@jg.id,LOSE_MID:@mid.id,LOSE_ACD:@adc.id,LOSE_SUP:@sup.id).count
    @wins = 3
    @losses = 1
  end
end
