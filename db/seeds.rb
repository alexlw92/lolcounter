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
