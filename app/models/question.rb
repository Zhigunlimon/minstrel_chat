class Question < ActiveRecord::Base
  has_many :answers, -> { order('best_answer DESC') }, dependent: :delete_all
  belongs_to :user

  attr_accessor :best_answer

  validates :title, :body, :user_id, presence: true

  def best_answer
    @best_answer = answers.where(best_answer: true).first
  end

  def best_answer=(best_answer)
    if self.best_answer != best_answer
      @best_answer.update_attribute(:best_answer, false) if @best_answer.present?
      best_answer.update_attribute(:best_answer, true)
    else
      @best_answer.update_attribute(:best_answer, false)
    end
  end
end