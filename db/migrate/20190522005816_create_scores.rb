class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.string :score
      t.integer :course_id
      t.integer :user_id
    end
  end
end
