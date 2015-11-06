# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Champion.create(name: "Aatrox")
c2 = Champion.create(name: "Ahri")
c3 = Champion.create(name: "Akali")
c4 = Champion.create(name: "Alistar")
c5 = Champion.create(name: "Amumu")
c6 = Champion.create(name: "Anivia")
c7 = Champion.create(name: "Annie")
c8 = Champion.create(name: "Ashe")
c9 = Champion.create(name: "Azir")
c10 = Champion.create(name: "Bard")

g1 = Game.create(RANK: "1",WIN_TOP: "1",WIN_JG: "2", WIN_MID: "3", WIN_ADC: "4", WIN_SUP: "5",LOSE_TOP: "6",LOSE_JG: "7", LOSE_MID: "8", LOSE_ADC: "9", LOSE_SUP: "10")
g2 = Game.create(RANK: "1",WIN_TOP: "1",WIN_JG: "2", WIN_MID: "3", WIN_ADC: "4", WIN_SUP: "5",LOSE_TOP: "6",LOSE_JG: "7", LOSE_MID: "8", LOSE_ADC: "9", LOSE_SUP: "10")
g3 = Game.create(RANK: "1",WIN_TOP: "1",WIN_JG: "2", WIN_MID: "3", WIN_ADC: "4", WIN_SUP: "5",LOSE_TOP: "6",LOSE_JG: "7", LOSE_MID: "8", LOSE_ADC: "9", LOSE_SUP: "10")
g4 = Game.create(RANK: "1",WIN_TOP: "6",WIN_JG: "7", WIN_MID: "8", WIN_ADC: "9", WIN_SUP: "10",LOSE_TOP: "1",LOSE_JG: "2", LOSE_MID: "3", LOSE_ADC: "4", LOSE_SUP: "5")

counter1 = Counter.create(champion_id: "1",
                          first_counter_name: "Anivia",wins_against_first:"1",losses_against_first:"3",
                          second_counter_name: "Annie",wins_against_second:"2",losses_against_second:"2",
                          third_counter_name: "Alistar",wins_against_third:"3",losses_against_third:"1")

c1.games << [g1, g2, g3, g4]
c2.games << [g1, g2, g3, g4]
c3.games << [g1, g2, g3, g4]
c4.games << [g1, g2, g3, g4]
c5.games << [g1, g2, g3, g4]
c6.games << [g1, g2, g3, g4]
c7.games << [g1, g2, g3, g4]
c8.games << [g1, g2, g3, g4]
c9.games << [g1, g2, g3, g4]
c10.games << [g1, g2, g3, g4]

champs = RiotApiModel.get_champions
champs["data"].each{|champ|
  c = Champion.find_or_create_by(id:champ[1]["id"])
  c.update(name:champ[1]["name"] )
}