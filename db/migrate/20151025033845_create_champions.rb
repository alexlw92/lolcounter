class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string "name"
      t.integer "game"
      t.timestamps null: false
    end
  end
end
