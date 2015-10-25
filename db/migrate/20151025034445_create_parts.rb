class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.belongs_to :champion, index: true
      t.belongs_to :game, index: true
      t.timestamps null: false
    end
  end
end
