class ChangeScoreToScorecard < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :score, :score_card
  end
end
