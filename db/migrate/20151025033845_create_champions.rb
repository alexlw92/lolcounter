class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string "name"
      t.string "nickname"
      t.timestamps null: false
    end
  end
end
