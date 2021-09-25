class Public::QuestionFavoritesController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    question_favorite = current_user.question_favorites.new(question_id: @question.id)
    question_favorite.save
  end

  def destroy
    @question = Question.find(params[:question_id])
    question_favorite = current_user.question_favorites.find_by(question_id: @question.id)
    question_favorite.destroy
  end
end
