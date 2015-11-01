class TeamcompController < ApplicationController
  def index
    top_champ = params[:top]
    jungle_champ = params[:jungle]
    mid_champ = params[:mid]
    adc_champ = params[:adc]
    support_champ = params[:support]

    #puts "DEBUG: Inside teamcomp#index!"

    #Do any database access codes below
    @champion = Champion.all
    @games = Game.all
    @top_name = top_champ
    @jungle_name = jungle_champ
    @mid_name = mid_champ
    @adc_name = adc_champ
    @support_name = support_champ

    @valid = false
    @top = @champion.where(name:@top_name).pluck(:id)
    @jungle = @champion.where(name:@jungle_name).pluck(:id)
    @mid = @champion.where(name:@mid_name).pluck(:id)
    @adc = @champion.where(name:@adc_name).pluck(:id)
    @support = @champion.where(name:@support_name).pluck(:id)
    #if(@champion.where(name:@top_name).count == 1 && @champion.where(name:@jungle_name).count == 1 && @champion.where(name:@mid_name).count == 1 && @champion.where(name:@adc_name).count == 1 && @champion.where(name:@support_name).count == 1)
    if(!@top.blank? && !@jungle.blank? && !@mid.blank? && !@adc.blank? && !@support.blank?)
      @wins = @games.where(WIN_TOP:@top,WIN_JG:@jungle,WIN_MID:@mid,WIN_ADC:@adc,WIN_SUP:@support).count
      @losses = @games.where(LOSE_TOP:@top,LOSE_JG:@jungle,LOSE_MID:@mid,LOSE_ADC:@adc,LOSE_SUP:@support).count
      @num_games = 0.0
      @num_games = @wins + @losses
      if(@num_games > 0)
        @win_rate = (@wins + 0.0)/@num_games
      else
        @win_rate = 0
      end
      @valid = true
    end
  end
end
