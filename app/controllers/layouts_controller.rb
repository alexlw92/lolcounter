class LayoutsController < ActionController::Base
  def
    index
    @results = RiotApiModel.retrieve_results("snvigoss")
    @blah = "blah"
  end
  def
    counterPick
    @blah = "counterPick"
  end
  def
    teamComp
    @blah = "teamComp"
  end
end