class AnswersController < ApplicationController
  before_action :load_question, only: :create
  def new
    @answer = Answer.new
    render :new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end