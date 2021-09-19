class Public::QuestionsController < ApplicationController
  # ログインしてなければログインページににリダイレクトする
  before_action :user_not_signin, {except: [:index, :unsolved, :solved, :show]}
  def index

  end

  def unsolved
    @questions = Question.where(thank: nil)
  end

  def solved
    @questions = Question.where.not(thank: nil)
  end

  def my_question
    @questions = current_user.questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(best_answer_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def check

  end

  def best_select
    @question = Question.find(params[:id])
  end

  # 投稿データのストロングパラメータ
  private

  def question_params
    params.require(:question).permit(:title, :body, :image)
  end

  def best_answer_params
    params.require(:question).permit(:thank, :best_answer_id)
  end
end
