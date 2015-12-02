# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


champs = RiotApiModel.get_champions
champs["data"].each{|champ|
  c = Champion.find_or_create_by(id:champ[1]["id"])
  c.update(name:champ[1]["name"] )
}


Champion.all.each {|champ|
  RiotApiModel.get_counters(champ.id, "TOP")
  RiotApiModel.get_counters(champ.id, "JG")
  RiotApiModel.get_counters(champ.id, "MID")
  RiotApiModel.get_counters(champ.id, "ADC")
  RiotApiModel.get_counters(champ.id, "SUP")
}