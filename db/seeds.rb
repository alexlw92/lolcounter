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
  c.update(name:champ[1]["name"])
  c.update(nickname:champ[1]["name"])
}
Champion.find(31).update(name: "Chogath")
Champion.find(36).update(name: "DrMundo")
Champion.find(9).update(name: "FiddleSticks")
Champion.find(59).update(name: "JarvanIV")
Champion.find(121).update(name: "Khazix")
Champion.find(96).update(name: "KogMaw")
Champion.find(121).update(name: "Leblanc")
Champion.find(64).update(name: "LeeSin")
Champion.find(11).update(name: "MasterYi")
Champion.find(21).update(name: "MissFortune")
Champion.find(421).update(name: "RekSai")
Champion.find(223).update(name: "TahmKench")
Champion.find(4).update(name: "TwistedFate")
Champion.find(161).update(name: "Velkoz")
Champion.find(62).update(name: "MonkeyKing")
Champion.find(5).update(name: "XinZhao")

Champion.all.each {|champ|
  RiotApiModel.get_counters(champ.id, "TOP")
  RiotApiModel.get_counters(champ.id, "JG")
  RiotApiModel.get_counters(champ.id, "MID")
  RiotApiModel.get_counters(champ.id, "ADC")
  RiotApiModel.get_counters(champ.id, "SUP")
}