class ChampionsController < ApplicationController
  #@@champsArray = Array.new; #Array used to keep track of all champion stats, so we don't query every time (kind of like caching)

  def index #This function just returns a list of all champions
    #expires_in 10.minutes, :public => true
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

    #if(@@champsArray.length == 0) #If we haven't queried the champsArray once yet.
      @@champsArray = Array.new
      Champion.all.each do |champion|
        # all_games = Game.where('WIN_TOP = ? OR LOSE_TOP = ? OR WIN_JG = ? OR LOSE_JG = ? OR WIN_MID = ?
        #                         OR LOSE_MID = ? OR WIN_ADC = ? OR LOSE_ADC = ? OR WIN_SUP = ? OR LOSE_SUP = ?',
        #                        champion.id, champion.id, champion.id, champion.id, champion.id, champion.id,
        #                        champion.id, champion.id, champion.id, champion.id);
        # total_games = all_games.count;

        top_win = Game.where(WIN_TOP:champion.id).count;
        top_loss = Game.where(LOSE_TOP:champion.id).count;
        topWinRate = number_to_percentage(top_win.to_f/(top_win+top_loss));
        jungle_win = Game.where(WIN_JG:champion.id).count;
        jungle_loss = Game.where(LOSE_JG:champion.id).count;
        jungleWinRate =  number_to_percentage(jungle_win.to_f/(jungle_win+jungle_loss));
        mid_win = Game.where(WIN_MID:champion.id).count;
        mid_loss = Game.where(LOSE_MID:champion.id).count;
        midWinRate =  number_to_percentage(mid_win.to_f/(mid_win+mid_loss));
        adc_win = Game.where(WIN_adc:champion.id).count;
        adc_loss = Game.where(LOSE_adc:champion.id).count;
        adcWinRate =  number_to_percentage(adc_win.to_f/(adc_win+adc_loss));
        support_win = Game.where(WIN_SUP:champion.id).count;
        support_loss = Game.where(LOSE_SUP:champion.id).count;
        supportWinRate =  number_to_percentage(support_win.to_f/(support_win+support_loss));

        total_games = top_win+top_loss+jungle_win+jungle_loss+mid_win+mid_loss+adc_win+adc_loss+support_win+support_loss;
        currentChamp = ChampionStats.new(champion.name, topWinRate,jungleWinRate,midWinRate,adcWinRate,supportWinRate, total_games);
        @@champsArray.append(currentChamp);
      end
    #end
    render :json => @@champsArray.to_json;
  end
end
