class CreateDatabase < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define(version: 0) do

      create_table "champions", force: :cascade do |t|
        t.string "name", limit: 20
      end

      create_table "games", force: :cascade do |t|
        t.integer "RANK",     limit: 4
        t.integer "WIN_TOP",  limit: 4
        t.integer "WIN_JG",   limit: 4
        t.integer "WIN_MID",  limit: 4
        t.integer "WIN_ADC",  limit: 4
        t.integer "WIN_SUP",  limit: 4
        t.integer "LOSE_TOP", limit: 4
        t.integer "LOSE_JG",  limit: 4
        t.integer "LOSE_MID", limit: 4
        t.integer "LOSE_ADC", limit: 4
        t.integer "LOSE_SUP", limit: 4
      end

      add_index "games", ["LOSE_ADC"], name: "lose_adc_fk_idx", using: :btree
      add_index "games", ["LOSE_JG"], name: "lose_jg_fk_idx", using: :btree
      add_index "games", ["LOSE_MID"], name: "lose_mid_fk_idx", using: :btree
      add_index "games", ["LOSE_SUP"], name: "lose_sup_fk_idx", using: :btree
      add_index "games", ["LOSE_TOP"], name: "lose_top_fk_idx", using: :btree
      add_index "games", ["RANK"], name: "rank_fk_idx", using: :btree
      add_index "games", ["WIN_ADC"], name: "win_adc_fk_idx", using: :btree
      add_index "games", ["WIN_JG"], name: "win_jg_fk_idx", using: :btree
      add_index "games", ["WIN_MID"], name: "win_mid_fk_idx", using: :btree
      add_index "games", ["WIN_SUP"], name: "win_sup_fk_idx", using: :btree
      add_index "games", ["WIN_TOP", "WIN_JG", "WIN_MID", "WIN_ADC", "LOSE_TOP", "LOSE_JG", "LOSE_MID", "LOSE_ADC", "LOSE_SUP"], name: "games_fk_idx", using: :btree

      create_table "ranks", force: :cascade do |t|
        t.string "rank", limit: 12
      end

      add_foreign_key "games", "champions", column: "LOSE_ADC", name: "lose_adc_fk"
      add_foreign_key "games", "champions", column: "LOSE_JG", name: "lose_jg_fk"
      add_foreign_key "games", "champions", column: "LOSE_MID", name: "lose_mid_fk"
      add_foreign_key "games", "champions", column: "LOSE_SUP", name: "lose_sup_fk"
      add_foreign_key "games", "champions", column: "LOSE_TOP", name: "lose_top_fk"
      add_foreign_key "games", "champions", column: "WIN_ADC", name: "win_adc_fk"
      add_foreign_key "games", "champions", column: "WIN_JG", name: "win_jg_fk"
      add_foreign_key "games", "champions", column: "WIN_MID", name: "win_mid_fk"
      add_foreign_key "games", "champions", column: "WIN_SUP", name: "win_sup_fk"
      add_foreign_key "games", "champions", column: "WIN_TOP", name: "win_top_fk"
      add_foreign_key "games", "ranks", column: "RANK", name: "rank_fk"
    end
  end

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end