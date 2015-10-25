class ChampionsController < ApplicationController
  def index
    @champions = Champion.all
  end

  def show
    @champion = Champion.find(params[:id])
    @games = @champion.games
    @total_games = @games.count
    @top_win = @games.where(WIN_TOP:@champion.id).count
    @top_loss = @total_games - @top_win
    @jungle_win = @games.where(WIN_JG:@champion.id).count
    @jungle_loss = @total_games - @jungle_win
    @mid_win = @games.where(WIN_MID:@champion.id).count
    @mid_loss = @total_games - @mid_win
    @adc_win = @games.where(WIN_ADC:@champion.id).count
    @adc_loss = @total_games - @adc_win
    @support_win = @games.where(WIN_SUP:@champion.id).count
    @support_loss = @total_games - @support_win
  end
end
