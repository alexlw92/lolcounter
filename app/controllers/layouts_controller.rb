class LayoutsController < ActionController::Base
  def index
    @results = RiotApiModel.retrieve_results("snvigoss")
    @blah = "blah"
  end

  def summonerLookup

  end

  def champions

  end

  def counterPicks
    @blah = "counterPick"
  end


  def teamComp
    @blah = "teamComp"
  end
end