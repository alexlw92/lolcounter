class ChampionsController < ApplicationController
  def index
    @champions = Champion.all
  end

  def show
    @champion = Champion.find(params[:id])
    # Can definitely speed up some of these queries... Or perhaps we should store #Games played associated with a champion
    # In the champions table
    @total_games = Game.where('WIN_TOP = ? OR LOSE_TOP = ? OR WIN_JG = ? OR LOSE_JG = ? OR WIN_MID = ?
                              OR LOSE_MID = ? OR WIN_ADC = ? OR LOSE_ADC = ? OR WIN_SUP = ? OR LOSE_SUP = ?',
                              @champion.id, @champion.id, @champion.id, @champion.id, @champion.id, @champion.id,
                              @champion.id, @champion.id, @champion.id, @champion.id).count;

    @top_win = Game.where(WIN_TOP:@champion.id).count;
    @top_loss = Game.where(LOSE_TOP:@champion.id).count;
    @jungle_win = Game.where(WIN_JG:@champion.id).count;
    @jungle_loss = Game.where(LOSE_JG:@champion.id).count;
    @mid_win = Game.where(WIN_MID:@champion.id).count;
    @mid_loss = Game.where(LOSE_MID:@champion.id).count;
    @adc_win = Game.where(WIN_ADC:@champion.id).count;
    @adc_loss = Game.where(LOSE_ADC:@champion.id).count;
    @support_win = Game.where(WIN_SUP:@champion.id).count;
    @support_loss = Game.where(LOSE_SUP:@champion.id).count;
  end
end
