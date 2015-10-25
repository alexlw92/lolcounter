class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer "RANK"
      t.integer "WIN_TOP"
      t.integer "WIN_JG"
      t.integer "WIN_MID"
      t.integer "WIN_ADC"
      t.integer "WIN_SUP"
      t.integer "LOSE_TOP"
      t.integer "LOSE_JG"
      t.integer "LOSE_MID"
      t.integer "LOSE_ADC"
      t.integer "LOSE_SUP"
      t.timestamps null: false
    end
  end
end
