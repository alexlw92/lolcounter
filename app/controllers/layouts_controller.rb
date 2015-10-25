class LayoutsController < ActionController::Base
  def index
    @results = RiotApiModel.retrieve_results("snvigoss")
    @blah = "blah"
  end
end