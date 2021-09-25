class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def favorite_blogs
    @user = User.find(params[:user_id])
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    favorites = @user.blog_favorites.where(user_id: @user.id).pluck(:blog_id)
    @blogs = Blog.find(favorites)
    @tags = Blog.tags_on(:tags)
  end

  def favorite_questions
    @user = User.find(params[:user_id])
    favorites = @user.question_favorites.where(user_id: @user.id).pluck(:question_id)
    @questions = Question.find(favorites)
  end

  def questions
    @user = User.find(params[:user_id])
    @questions = @user.questions.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end
end
