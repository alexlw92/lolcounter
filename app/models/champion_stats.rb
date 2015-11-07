#This class is used as a object representing 1 champion's stats.
# It is used by the champions_controller which returns a JSON collection of all champions
class ChampionStats
  def initialize(name, top, mid, jung, adc, sup, tot)
    @champName = name;
    @topWinRate = top;
    @midWinRate = mid;
    @jungWinRate = jung;
    @adcWinRate = adc;
    @supWinRate = sup;
    @totalGames = tot;
  end
end