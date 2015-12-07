class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :find_question, only: [:show, :destroy]

  def index
    @questions = Question.all
  end

  def show

  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if @question.user_id == current_user.id && @question.destroy
      flash[:notice] = 'Your question was successfully deleted.'
    else
      flash[:notice] = 'Your question was not deleted.'
    end
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
