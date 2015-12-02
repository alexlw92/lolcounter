class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.integer "champion_id"
      t.string "role"
      t.string "first_counter_name"
      t.integer "wins_against_first"
      t.integer "losses_against_first"
      t.string "second_counter_name"
      t.integer "wins_against_second"
      t.integer "losses_against_second"
      t.string "third_counter_name"
      t.integer "wins_against_third"
      t.integer "losses_against_third"
      t.timestamps null: false
    end
  end
end
