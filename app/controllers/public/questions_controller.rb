class Public::QuestionsController < ApplicationController
  # ログインしてなければログインページににリダイレクトする
  before_action :user_not_signin, {except: [:index, :unsolved, :solved, :show]}
  def index

  end

  def unsolved
    @questions = Question.where(thank: nil)
  end

  def solved

  end

  def my_question

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

  end

  def check

  end

  def best_select

  end

  # 投稿データのストロングパラメータ
  private

  def question_params
    params.require(:question).permit(:title, :body, :image)
  end
end
