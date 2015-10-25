class Champion < ActiveRecord::Base
  has_many :parts
  has_many :games, through: :parts

end
