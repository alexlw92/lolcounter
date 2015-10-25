class Game < ActiveRecord::Base
  has_many :parts
  has_many :champions, through: :parts
end
