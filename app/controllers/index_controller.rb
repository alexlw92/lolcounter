class IndexController < ApplicationController
  def index
    expires_in 10.minutes, :public => true
    render 'layouts/index'
  end
end