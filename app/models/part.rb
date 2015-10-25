class Part < ActiveRecord::Base
  belongs_to :champion
  belongs_to :game
end
