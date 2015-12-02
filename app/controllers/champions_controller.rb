class ChampionsController < ApplicationController
  @@champsArray = Array.new; #Array used to keep track of all champion stats, so we don't query every time (kind of like caching)

  def index #This function just returns a list of all champions
    expires_in 10.minutes, :public => true
    @champions = Champion.all;
  end

  def show #This function shows the stats for 1 specific champion
    @champion = Champion.find(params[:id]);
    # Can definitely speed up some of these queries...
    @total_games = Game.where('WIN_TOP = ? OR LOSE_TOP = ? OR WIN_JG = ? OR LOSE_JG = ? OR WIN_MID = ?
                              OR LOSE_MID = ? OR WIN_ADC = ? OR LOSE_ADC = ? OR WIN_SUP = ? OR LOSE_SUP = ?',
                              @champion.id, @champion.id, @champion.id, @champion.id, @champion.id, @champion.id,
                              @champion.id, @champion.id, @champion.id, @champion.id).count;

    @top_win = Game.where(WIN_TOP:@champion.id).count;
    @top_loss = Game.where(LOSE_TOP:@champion.id).count;
    @topWinRate = @top_win.to_f/(@top_win+@top_loss);
    @jungle_win = Game.where(WIN_JG:@champion.id).count;
    @jungle_loss = Game.where(LOSE_JG:@champion.id).count;
    @jungleWinRate = @jungle_win.to_f/(@jungle_win+@jungle_loss);
    @mid_win = Game.where(WIN_MID:@champion.id).count;
    @mid_loss = Game.where(LOSE_MID:@champion.id).count;
    @midWinRate = @mid_win.to_f/(@mid_win+@mid_loss);
    @adc_win = Game.where(WIN_ADC:@champion.id).count;
    @adc_loss = Game.where(LOSE_ADC:@champion.id).count;
    @adcWinRate = @adc_win.to_f/(@adc_win+@adc_loss);
    @support_win = Game.where(WIN_SUP:@champion.id).count;
    @support_loss = Game.where(LOSE_SUP:@champion.id).count;
    @supportWinRate = @support_win.to_f/(@support_win+@support_loss);
  end

  #Helper method that returns the percentage representation of number to 2 decimal places
  def number_to_percentage(number)
     s = (number*100).round(2).to_s + '%';
     if(s == 'NaN%')
       return 'No Games';
     end
     return s;
  end

  def retrieveAllChampStats #This function will return JSON data of ALL champ stats. This RUNS VERY SLOWLY 10-20secs...
    #WE CAN ALSO PRE-COMPUTE THESE RESULTS UPON DEPLOYMENT SO THE USER DOESN'T HAVE DECREASED EXPERIENCE
    #This should be run at deployment and have the results cached.
    if(@@champsArray.length != 0)
      render :json => @@champsArray.to_json;
      return
    end

    mapTopWin = Hash.new(0)
    mapTopLoss = Hash.new(0)
    mapJungleWin = Hash.new(0)
    mapJungleLoss = Hash.new(0)
    mapMidWin = Hash.new(0)
    mapMidLoss = Hash.new(0)
    mapAdcWin = Hash.new(0)
    mapAdcLoss = Hash.new(0)
    mapSupWin = Hash.new(0)
    mapSupLoss = Hash.new(0)

    Game.all.each do |game|
      mapTopWin[game.WIN_TOP] = mapTopWin[game.WIN_TOP] + 1
      mapTopLoss[game.LOSE_TOP] = mapTopLoss[game.LOSE_TOP] + 1
      mapJungleWin[game.WIN_JG] = mapJungleWin[game.WIN_JG] + 1
      mapJungleLoss[game.LOSE_JG] =  mapJungleLoss[game.LOSE_JG] + 1
      mapMidWin[game.WIN_MID] = mapMidWin[game.WIN_MID] + 1
      mapMidLoss[game.LOSE_MID] = mapMidLoss[game.LOSE_MID] + 1
      mapAdcWin[game.WIN_ADC] = mapAdcWin[game.WIN_ADC] + 1
      mapAdcLoss[game.LOSE_ADC] = mapAdcLoss[game.LOSE_ADC] + 1
      mapSupWin[game.WIN_SUP] = mapSupWin[game.WIN_SUP] + 1
      mapSupLoss[game.LOSE_SUP] = mapSupLoss[game.LOSE_SUP] + 1
    end

    Champion.all.each do |champion|
      top_win = mapTopWin[champion.id]
      top_loss = mapTopLoss[champion.id]
      topWinRate = number_to_percentage(top_win.to_f/(top_win+top_loss)) + ' | ' + (top_win+top_loss).to_s + ' played'
      jungle_win = mapJungleWin[champion.id]
      jungle_loss = mapJungleLoss[champion.id]
      jungleWinRate = number_to_percentage(jungle_win.to_f/(jungle_win+jungle_loss)) + ' | ' + (jungle_win+jungle_loss).to_s + ' played'
      mid_win = mapMidWin[champion.id]
      mid_loss = mapMidLoss[champion.id]
      midWinRate = number_to_percentage(mid_win.to_f/(mid_win+mid_loss)) + ' | ' + (mid_win+mid_loss).to_s + ' played'
      adc_win = mapAdcWin[champion.id]
      adc_loss = mapAdcLoss[champion.id]
      adcWinRate = number_to_percentage(adc_win.to_f/(adc_win+adc_loss)) + ' | ' + (adc_win+adc_loss).to_s + ' played';
      support_win = mapSupWin[champion.id]
      support_loss = mapSupLoss[champion.id]
      supportWinRate = number_to_percentage(support_win.to_f/(support_win+support_loss)) + ' | ' + (support_win+support_loss).to_s + ' played';
      total_games = top_win+top_loss+jungle_win+jungle_loss+mid_win+mid_loss+adc_win+adc_loss+support_win+support_loss;
      currentChamp = ChampionStats.new(champion.name,topWinRate,jungleWinRate,midWinRate,adcWinRate,supportWinRate,total_games);
      @@champsArray.append(currentChamp);
    end
    render :json => @@champsArray.to_json;
  end
end
