class Public::QuestionsController < ApplicationController
  # ログインしてなければログインページににリダイレクトする
  before_action :user_not_signin, { except: %i(index unsolved solved show search) }
  def index
    @question_solved = Question.where.not(thank: nil).last(4).reverse
    @question_unsolved = Question.where(thank: nil).last(4).reverse
  end

  def unsolved
    @questions = Question.where(thank: nil).order(created_at: :desc).page(params[:page]).per(10)
  end

  def solved
    @questions = Question.where.not(thank: nil).order(created_at: :desc).page(params[:page]).per(10)
  end

  # def my_question
  #   @questions = current_user.questions.page(params[:page]).per(10)
  # end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = '投稿に成功しました'
      redirect_to question_path(@question)
    else
      flash[:alert] = '入力に間違いがあります'
      @question = Question.new
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @best_answer = @question.answers.find(@question.best_answer_id) if @question.best_answer_id.present?
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(best_answer_params) && best_answer_id_present?
      flash[:notice] = 'ベストアンサーを選択しました'
      redirect_to question_path(@question)
    else
      flash[:alert] = 'ベストアンサーを必ず選択してください'
      @question = Question.find(params[:id])
      render :best_select
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.user_id == current_user.id
      @question.destroy
      flash[:alert] = '質問を消去しました'
      redirect_to user_questions_path(current_user)
    else
      redirect_to questions_path
    end
  end

  def search
    @search_word = params[:search_word]
    if params[:search_word].present?
      @question_solved = Question.where.not(thank: nil).where('title Like ?', "%#{@search_word}%")
      @question_unsolved = Question.where(thank: nil).where('title Like ?', "%#{@search_word}%")
    else
      redirect_to questions_path
    end
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

  # ベストアンサー用
  def best_answer_id_present?
    params.require(:question).permit(:best_answer_id).present?
  end
end
