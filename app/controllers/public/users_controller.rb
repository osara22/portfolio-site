class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def favorite_blogs
    @user = User.find(params[:user_id])
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    favorites = @user.blog_favorites.where(user_id: @user.id).order(created_at: :desc).pluck(:blog_id)
    @blogs = Blog.find(favorites)
    @tags = Blog.tags_on(:tags).most_used
  end

  def favorite_questions
    @user = User.find(params[:user_id])
    favorites = @user.question_favorites.where(user_id: @user.id).order(created_at: :desc).pluck(:question_id)
    @questions = Question.find(favorites)
  end

  def questions
    @user = User.find(params[:user_id])
    @questions = @user.questions.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'プロフィールを変更しました'
      redirect_to user_path(@user.id)
    else
      flash[:alert] = '入力に間違いがあります'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end
end
