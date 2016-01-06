class AnswersController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_question, only: :create
  before_action :find_answer, only: [:destroy, :update, :best_answer]


  def create
    @answer = @question.answers.new(answer_params.merge!(user: current_user))
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @question = @answer.question
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def best_answer
    question = @answer.question
    if question.best_answer != @answer
      question.best_answer = @answer
      render template: 'answers/select_best_answer'
    else
      question.best_answer = nil
      render template: 'answers/cancel_best_answer'
    end
    question.save
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end