class Public::BlogsController < ApplicationController
  before_action :user_not_signin, {only: [:my_favorite]}
  def index

  end

  def show
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
    @blog_tags = Blog.find(params[:id]).tag_counts_on(:tags)
    @tags = Blog.tags_on(:tags)
    impressionist(@blog, nil, unique: [:request_hash])
  end

  def my_favorite
    @slide_blogs = Blog.order('impressions_count DESC').take(5)
    favorites = BlogFavorite.where(user_id: current_user.id).pluck(:blog_id)
    @blogs = Blog.find(favorites)
    @tags = Blog.tags_on(:tags)
  end
end
