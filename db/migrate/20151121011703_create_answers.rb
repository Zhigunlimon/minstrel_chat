class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.text :body
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
