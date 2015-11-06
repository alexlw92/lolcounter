# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

counter1 = Counter.create(champion_id: "1",
                          first_counter_name: "Anivia",wins_against_first:"1",losses_against_first:"3",
                          second_counter_name: "Annie",wins_against_second:"2",losses_against_second:"2",
                          third_counter_name: "Alistar",wins_against_third:"3",losses_against_third:"1")

