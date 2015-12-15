class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :load_question, only: [:create, :new]
  before_action :find_answer, only: :destroy
  def new
    @answer = Answer.new
    render :new
  end

  def create
    @answer = @question.answers.new(answer_params.merge!(user: current_user))
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question = @answer.question
    if current_user.author_of?(@answer) && @answer.destroy
      flash[:notice] = 'Your answer was successfully deleted.'
    else
      flash[:notice] = 'Your answer was not deleted.'
    end
    redirect_to question_path(@question)
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