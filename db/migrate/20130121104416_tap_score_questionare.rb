class TapScoreQuestionare < ActiveRecord::Migration
  def change
    create_table :tap_score_questions do |t|
        t.string :question_text
        t.string :answer_type
    end
  end
end


class Answers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :answer_text
    end
  end
end