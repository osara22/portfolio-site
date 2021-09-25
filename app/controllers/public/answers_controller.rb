class Public::AnswersController < ApplicationController
  # ログインユーザーの記事に回答しようとしたらroot_pathにリダイレクトする
  before_action :current_user_signin
  def new
    @answer = Answer.new
    @question = Question.find(params[:id])
  end

  def check; end

  def create
    question = Question.find(params[:id])
    answer = current_user.answers.new(answer_params)
    answer.question_id = question.id
    if answer.save
      flash[:notice] = '投稿に成功しました'
      redirect_to question_path(question)
    else
      flash[:alert] = '入力してください'
      @answer = Answer.new
      @question = Question.find(params[:id])
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
